module 0x4ef52c4c0d50157e0a771377d4b83f41357bd4483f8c32847c7c342f09666692::mame {
    struct MAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MAME>(arg0, 9, untag(b"SMAME"), untag(b"NMame Inu"), untag(b"D||{\"twitter\":\"https://x.com/mamebnb\",\"website\":\"https://mamebnb.com/\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreihfgbnmnkopwgclveewpmjppv4ct47ttxjuaiebja7bt7nuvgykaq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<MAME>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<MAME>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MAME>>(0x2::coin::mint<MAME>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

