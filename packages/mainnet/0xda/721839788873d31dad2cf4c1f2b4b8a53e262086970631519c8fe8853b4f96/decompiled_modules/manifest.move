module 0xda721839788873d31dad2cf4c1f2b4b8a53e262086970631519c8fe8853b4f96::manifest {
    struct MANIFEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANIFEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MANIFEST>(arg0, 9, untag(b"SMANIFEST"), untag(b"NMANIFEST"), untag(b"D||{\"twitter\":\"https://x.com/manifestsui\",\"website\":\"https://themanifesttimes.com/\",\"telegram\":\"https://t.me/manifestsui\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreiffrxf5nqqnu3is6fimbjitcpdighxfmn7mctc2a6ujeq36emsahq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<MANIFEST>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<MANIFEST>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MANIFEST>>(0x2::coin::mint<MANIFEST>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

