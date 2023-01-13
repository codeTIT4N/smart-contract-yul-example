const path = require("path");
const fs = require("fs");
const solc = require("solc");

const outputPath = path.resolve(__dirname, "..", "build", "OptimizedYul.bytecode.json");

const inputPath = path.resolve(__dirname, "..", "contracts", "OptimizedYul.sol");
const source = fs.readFileSync(inputPath, "utf-8");

var input = {
    language: 'Yul',
    sources: {
        'OptimizedYul.sol': {
            content: source
        }
    },
    settings: {
        outputSelection: {
            '*': {
                '*': ["evm.bytecode"]
            }
        },
        "optimizer": { "enabled": true, "runs": 1, "details": { "yul": true } }
    }
};

const compiledContract = solc.compile(JSON.stringify(input));
console.log(compiledContract);
const bytecode = JSON.parse(compiledContract).contracts["OptimizedYul.sol"].OptimizedYul.evm.bytecode.object;

fs.writeFile(outputPath, JSON.stringify(bytecode), (err) => { });

console.log("done");
