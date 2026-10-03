module 0x7975db8f9bf7e23dad67072dcbc3130fc8d9d4c82b51a2de2304d02581f58b39::ika {
    struct IKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<IKA>(arg0, 9, untag(b"SIKA"), untag(b"NIKA Token"), untag(b"D||{\"twitter\":\"https://x.com/ikadotxyz\",\"website\":\"https://ika.xyz\",\"telegram\":\"https://t.me/ikadotxyz\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreihwlspibiymvte3xcrbvoibtij7my6mi4upcnywycgzym2ugouyue"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<IKA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<IKA>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<IKA>>(0x2::coin::mint<IKA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

