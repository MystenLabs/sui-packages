# sui-packages

This repository provides an easy way for interested developers to
access the bytecode and some metadata for Sui packages published to
both the mainnet and the testnet chains.

It contains:

* BCS for packages
* Bytecode
* Decompiled modules (mainnet only)


Directory format:


packages/$NETWORK/0x$FIRST_2/$REMAINING_62/(bcs.json|bytecode/|decompiled/)