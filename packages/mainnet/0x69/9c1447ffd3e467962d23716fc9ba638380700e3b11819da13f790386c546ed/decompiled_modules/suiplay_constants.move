module 0xd7b0a6b6832c2693ebafab2e71fb79ed12653c4073d39acbc9f712d0682fdd57::suiplay_constants {
    public fun max_exalted_units() : u64 {
        8300
    }

    public fun max_mythics_units() : u64 {
        1700
    }

    public fun supported_chains() : vector<vector<u8>> {
        vector[b"Sui", b"Solana", b"Ethereum", b"Coupon"]
    }

    public fun tier_exalted_name() : vector<u8> {
        b"The Exalted"
    }

    public fun tier_mythics_name() : vector<u8> {
        b"The Mythics"
    }

    // decompiled from Move bytecode v6
}

