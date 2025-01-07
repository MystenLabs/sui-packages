module 0xbe99f746ddeffc13b1bd589026846e61d480d896edb623a0996f95e0a9fd7755::suiw_rd_28_12_2024 {
    struct SUIW_RD_28_12_2024 has drop {
        dummy_field: bool,
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<SUIW_RD_28_12_2024>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<SUIW_RD_28_12_2024>(arg0) + arg1 <= 18000000000000000000, 2);
        0x2::coin::mint_and_transfer<SUIW_RD_28_12_2024>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUIW_RD_28_12_2024, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 626 || 0x2::tx_context::epoch(arg1) == 627, 1);
        let (v0, v1) = 0x2::coin::create_currency<SUIW_RD_28_12_2024>(arg0, 9, b"SuiW", b"SuiWorld", x"3c3c535549574f524c443e3e0a205768617420697320537569576f726c643f0a537569576f726c64206973206e6f74206a757374206120746f6b656e3b20697420697320746865206761746577617920746f2061206e657720657261206f6620696e746567726174696f6e20616e6420646576656c6f706d656e74206f6e207468652053756920626c6f636b636861696e2e2044657369676e656420746f206472697665206d6173732061646f7074696f6e2c207468697320746f6b656e206861732074686520636c65617220676f616c206f66206d616b696e672074686520537569206e6574776f726b20746865207265666572656e6365207374616e6461726420666f7220616c6c2070726f6a656374732c206170706c69636174696f6e7320616e6420757365727320696e2074686520576562332073706163652e0a0a536c6f67616e3a202254686520776f726c64206f6620706f73736962696c697469657320626567696e7320686572653a20537569576f726c642e22", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreide6r5oki56m422l6fbzafku7u4uswsd2jgug5fnprtxtkarmmmbi.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIW_RD_28_12_2024>(&mut v2, 1000000000000000000, @0x965faad24d229822eb61ba02bde89064d96a0452ccb26daf81db14f8ab2ac24a, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIW_RD_28_12_2024>>(v2, @0x965faad24d229822eb61ba02bde89064d96a0452ccb26daf81db14f8ab2ac24a);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIW_RD_28_12_2024>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<SUIW_RD_28_12_2024>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIW_RD_28_12_2024>>(arg0);
    }

    public entry fun update_metadata(arg0: &mut 0x2::coin::TreasuryCap<SUIW_RD_28_12_2024>, arg1: &mut 0x2::coin::CoinMetadata<SUIW_RD_28_12_2024>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<SUIW_RD_28_12_2024>(arg0, arg1, arg2);
        0x2::coin::update_symbol<SUIW_RD_28_12_2024>(arg0, arg1, arg3);
        0x2::coin::update_description<SUIW_RD_28_12_2024>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<SUIW_RD_28_12_2024>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

