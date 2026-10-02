module 0xa71ac934aa2924c62e4f70543cb75494456d28e522a602c03f0644f6ee72fb40::vicefun {
    struct VICEFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VICEFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<VICEFUN>(arg0, 9, untag(b"SVICEFUN"), untag(b"NVicefun"), untag(b"D||{\"twitter\":\"https://x.com/ViceFun\",\"website\":\"https://vicefun.com\",\"telegram\":\"https://t.me/ViceFun\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreicrk76lfmttoab2rq3ahqckiqvvkt6ynjzvwrh5cc6yisnt33cqqm"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<VICEFUN>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<VICEFUN>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<VICEFUN>>(0x2::coin::mint<VICEFUN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

