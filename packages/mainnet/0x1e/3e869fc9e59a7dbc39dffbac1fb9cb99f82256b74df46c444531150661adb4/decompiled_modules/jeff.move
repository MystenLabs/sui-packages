module 0x1e3e869fc9e59a7dbc39dffbac1fb9cb99f82256b74df46c444531150661adb4::jeff {
    struct JEFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEFF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = vector[9, 1000000000000000, 0];
        let v1 = vector[b"JEFF", b"JEFF", b"Jeff Bezos founded e-commerce giant Amazon in 1994 out of his Seattle garage", b"https://www.google.com/url?sa=i&url=https%3A%2F%2Fkorii.slate.fr%2Fbiz%2Fjeff-bezos-conquete-spatiale-blue-origin&psig=AOvVaw299ia4Bwrb9rO9TsStcSZP&ust=1754718532807000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCMDB0Y7C-o4DFQAAAAAdAAAAABAd"];
        let v2 = vector[b"JEFF", b"JEFF", b"Jeff Bezos founded e-commerce giant Amazon in 1994 out of his Seattle garage", b"https://www.google.com/url?sa=i&url=https%3A%2F%2Fkorii.slate.fr%2Fbiz%2Fjeff-bezos-conquete-spatiale-blue-origin&psig=AOvVaw299ia4Bwrb9rO9TsStcSZP&ust=1754718532807000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCMDB0Y7C-o4DFQAAAAAdAAAAABAd"];
        let v3 = vector[b"JEFF", b"JEFF", b"Jeff Bezos founded e-commerce giant Amazon in 1994 out of his Seattle garage", b"https://www.google.com/url?sa=i&url=https%3A%2F%2Fkorii.slate.fr%2Fbiz%2Fjeff-bezos-conquete-spatiale-blue-origin&psig=AOvVaw299ia4Bwrb9rO9TsStcSZP&ust=1754718532807000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCMDB0Y7C-o4DFQAAAAAdAAAAABAd"];
        let v4 = vector[b"JEFF", b"JEFF", b"Jeff Bezos founded e-commerce giant Amazon in 1994 out of his Seattle garage", b"https://www.google.com/url?sa=i&url=https%3A%2F%2Fkorii.slate.fr%2Fbiz%2Fjeff-bezos-conquete-spatiale-blue-origin&psig=AOvVaw299ia4Bwrb9rO9TsStcSZP&ust=1754718532807000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCMDB0Y7C-o4DFQAAAAAdAAAAABAd"];
        let (v5, v6) = 0x2::coin::create_currency<JEFF>(arg0, (*0x1::vector::borrow<u64>(&v0, 0) as u8), *0x1::vector::borrow<vector<u8>>(&v1, 0), *0x1::vector::borrow<vector<u8>>(&v2, 1), *0x1::vector::borrow<vector<u8>>(&v3, 2), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(*0x1::vector::borrow<vector<u8>>(&v4, 3))), arg1);
        let v7 = v5;
        let v8 = 0x2::tx_context::sender(arg1);
        let v9 = vector[9, 1000000000000000, 0];
        if (*0x1::vector::borrow<u64>(&v9, 1) > 0) {
            let v10 = vector[9, 1000000000000000, 0];
            0x2::coin::mint_and_transfer<JEFF>(&mut v7, *0x1::vector::borrow<u64>(&v10, 1), v8, arg1);
        };
        let (v11, v12) = 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::new<JEFF>(v7, arg1);
        let v13 = v12;
        let v14 = v11;
        let v15 = vector[9, 1000000000000000, 0];
        if (*0x1::vector::borrow<u64>(&v15, 2) > 0) {
            let v16 = vector[9, 1000000000000000, 0];
            0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::set_maximum_supply(&mut v13, *0x1::vector::borrow<u64>(&v16, 2));
        };
        let v17 = vector[true, true, true, false];
        if (*0x1::vector::borrow<bool>(&v17, 0)) {
            0x2::transfer::public_transfer<0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::MintCap>(0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::create_mint_cap(&mut v13, arg1), v8);
        };
        let v18 = vector[true, true, true, false];
        if (*0x1::vector::borrow<bool>(&v18, 1)) {
            0x2::transfer::public_transfer<0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::BurnCap>(0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::create_burn_cap(&mut v13, arg1), v8);
        };
        let v19 = vector[true, true, true, false];
        if (*0x1::vector::borrow<bool>(&v19, 2)) {
            0x2::transfer::public_transfer<0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::MetadataCap>(0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::create_metadata_cap(&mut v13, arg1), v8);
        };
        let v20 = vector[true, true, true, false];
        if (*0x1::vector::borrow<bool>(&v20, 3)) {
            0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::allow_public_burn(&mut v13, &mut v14);
        };
        0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::destroy_witness<JEFF>(&mut v14, v13);
        0x2::transfer::public_share_object<0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard>(v14);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEFF>>(v6);
    }

    // decompiled from Move bytecode v6
}

