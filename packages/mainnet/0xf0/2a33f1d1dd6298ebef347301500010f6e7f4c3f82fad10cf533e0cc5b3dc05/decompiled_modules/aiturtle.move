module 0xf02a33f1d1dd6298ebef347301500010f6e7f4c3f82fad10cf533e0cc5b3dc05::aiturtle {
    struct AITURTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AITURTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AITURTLE>(arg0, 9, untag(b"SAITURTLE"), untag(b"NARTIFICIAL TURTLE"), untag(b"D||{\"twitter\":\"https://x.com/THEAITURTLE\",\"website\":\"https://artificialturtle.com/\",\"telegram\":\"https://t.me/ARTIFICIALTURTLE\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreid4bf56gtxa4cwfggrxfce4hwdwzaadm4nlx4zohscovpdpmk2of4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<AITURTLE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<AITURTLE>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AITURTLE>>(0x2::coin::mint<AITURTLE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

