module 0xc4430f85c0dcaa113fc232822f404dd60d439f87a58e52f7b7cfc7d8d45cbb28::dex_bluefin {
    public fun get_bluefin_config() : (address, address, address) {
        (@0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267, @0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267, @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa)
    }

    public fun is_bluefin_available() : bool {
        true
    }

    public fun swap_sui_to_wusdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xc4430f85c0dcaa113fc232822f404dd60d439f87a58e52f7b7cfc7d8d45cbb28::wusdc::WUSDC> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        assert!(v0 >= 1000, 2);
        abort 99
    }

    public fun swap_wusdc_to_sui(arg0: 0x2::coin::Coin<0xc4430f85c0dcaa113fc232822f404dd60d439f87a58e52f7b7cfc7d8d45cbb28::wusdc::WUSDC>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0xc4430f85c0dcaa113fc232822f404dd60d439f87a58e52f7b7cfc7d8d45cbb28::wusdc::WUSDC>(&arg0);
        assert!(v0 > 0, 1);
        assert!(v0 >= 1000, 2);
        abort 99
    }

    // decompiled from Move bytecode v6
}

