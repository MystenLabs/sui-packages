module 0xc0c1712e42f4f29b5a878c36a58cba8dbd7e677c63297034ccf77646916f8bc8::chakra_nft {
    struct ChakraNFT has key {
        id: 0x2::object::UID,
        number: u64,
        minted_by: address,
        s1_alloc: u64,
        s2_alloc: u64,
        referral_codes: 0x1::string::String,
        referee_code: 0x1::string::String,
        maya_burnt: u64,
    }

    public fun mint(arg0: u64, arg1: address, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = ChakraNFT{
            id             : 0x2::object::new(arg7),
            number         : arg0,
            minted_by      : arg1,
            s1_alloc       : arg2,
            s2_alloc       : arg3,
            referral_codes : arg4,
            referee_code   : arg5,
            maya_burnt     : arg6,
        };
        0x2::transfer::transfer<ChakraNFT>(v0, 0x2::tx_context::sender(arg7));
        0x2::object::id<ChakraNFT>(&v0)
    }

    // decompiled from Move bytecode v6
}

