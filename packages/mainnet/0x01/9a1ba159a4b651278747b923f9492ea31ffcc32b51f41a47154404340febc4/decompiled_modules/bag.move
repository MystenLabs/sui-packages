module 0x19a1ba159a4b651278747b923f9492ea31ffcc32b51f41a47154404340febc4::bag {
    struct BAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BAG>(arg0, 9, untag(b"SBAG"), untag(b"NBag"), untag(b"D||{\"twitter\":\"https://x.com/Bagejeq\",\"website\":\"https://bagsui.fun\",\"telegram\":\"https://t.me/bagonsui\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreihb67jm7jvbrrlamlfordjtffdq6w5zn27vga3d2hugjnkz277g3a"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<BAG>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<BAG>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BAG>>(0x2::coin::mint<BAG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

