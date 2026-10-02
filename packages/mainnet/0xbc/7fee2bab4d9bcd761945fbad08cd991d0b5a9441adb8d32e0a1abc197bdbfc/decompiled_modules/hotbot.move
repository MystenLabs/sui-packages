module 0xbc7fee2bab4d9bcd761945fbad08cd991d0b5a9441adb8d32e0a1abc197bdbfc::hotbot {
    struct HOTBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOTBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<HOTBOT>(arg0, 9, untag(b"SHOTBOT"), untag(b"NHot Bot"), untag(b"D"), untag(b"Ihttps://imortal.buzz/i/bafkreifv2ufjuo3gl53vyhzzmhci7kl2wom7uazaw2fply7cs3zdasdhp4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<HOTBOT>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<HOTBOT>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<HOTBOT>>(0x2::coin::mint<HOTBOT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

