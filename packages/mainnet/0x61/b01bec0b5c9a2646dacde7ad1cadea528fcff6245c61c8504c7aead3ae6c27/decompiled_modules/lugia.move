module 0x61b01bec0b5c9a2646dacde7ad1cadea528fcff6245c61c8504c7aead3ae6c27::lugia {
    struct LUGIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUGIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LUGIA>(arg0, 9, untag(b"SLUGIA"), untag(b"NSilver Storm"), untag(b"D@Ourblastbot @Ourblastbot deploy $LUGIA, name : Silver Storm, on Maelstrom https://t.co/9VzcoJb4JC"), untag(b"Ihttps://pbs.twimg.com/media/HTT0LaEaAAAMmIH.jpg"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<LUGIA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<LUGIA>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LUGIA>>(0x2::coin::mint<LUGIA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

