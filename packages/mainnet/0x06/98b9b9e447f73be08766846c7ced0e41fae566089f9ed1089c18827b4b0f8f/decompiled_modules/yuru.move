module 0x698b9b9e447f73be08766846c7ced0e41fae566089f9ed1089c18827b4b0f8f::yuru {
    struct YURU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YURU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<YURU>(arg0, 9, untag(b"SYURU"), untag(b"NYURU COIN"), untag(b"D||{\"twitter\":\"https://x.com/yuru_coin\",\"website\":\"https://en.coin.yurugp.jp/\",\"telegram\":\"https://t.me/yurucoin\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreigsuy7o3g4nzibvdpdxmsqfxuxuf2jum3bhczqdjmswdllfyln65q"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<YURU>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<YURU>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<YURU>>(0x2::coin::mint<YURU>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

