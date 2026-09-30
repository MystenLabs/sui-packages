module 0x950145ff7b785970801e137ae05cb4b23d994c6cfa255902a8f614a8d651a7ea::blub {
    struct BLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BLUB>(arg0, 9, untag(b"SBLUB"), untag(b"NBLUB"), untag(b"D||{\"twitter\":\"https://x.com/blubsui\",\"website\":\"https://blubsui.com\",\"telegram\":\"https://t.me/blubsui\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreiemsgkfcqlqeb2y2vhubg5fdgfvcbc2cnrvkzupkoxmlpl2kl5je4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<BLUB>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<BLUB>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BLUB>>(0x2::coin::mint<BLUB>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

