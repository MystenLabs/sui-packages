module 0xe3c64041c46ebb7214cb1907b5477ed9e0848dd0dcb0573810d7af87cb830d92::elon {
    struct ELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ELON>(arg0, 9, untag(b"SELON"), untag(b"NElon Coin"), untag(b"D||{\"website\":\"https://pump.fun/coin/GY9mZfyPpxXxBXBxS2hB2XjhP3kfUsywTvgveozxpump\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreieengct633usbvzwut5i5j6ykmfh5mxdni32qvsdc5o26a6ttwloi"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<ELON>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<ELON>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ELON>>(0x2::coin::mint<ELON>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

