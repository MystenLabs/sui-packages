module 0x68289333ddfc0b33a40d65532b69d4cb48876d608bb8add0dc1fe0b3fa3d3015::party {
    struct PARTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARTY>(arg0, 9, b"PARTY", b"PuffyPartyWithSui", b"Imagine what can this party be, and then all this came on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844023153036795904/RRcbrEG_.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PARTY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARTY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PARTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

