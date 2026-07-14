module 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::nft {
    struct SaplingNFT has store, key {
        id: 0x2::object::UID,
        issuer: address,
        name: 0x1::string::String,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    public fun destroy_mint_cap(arg0: MintCap) {
        let MintCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<MintCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint_sapling(arg0: &MintCap, arg1: address, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = SaplingNFT{
            id     : 0x2::object::new(arg3),
            issuer : 0x2::tx_context::sender(arg3),
            name   : arg2,
        };
        0x2::transfer::public_transfer<SaplingNFT>(v0, arg1);
    }

    // decompiled from Move bytecode v7
}

