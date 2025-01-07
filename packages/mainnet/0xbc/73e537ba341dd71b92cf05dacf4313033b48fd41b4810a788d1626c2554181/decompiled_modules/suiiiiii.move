module 0xbc73e537ba341dd71b92cf05dacf4313033b48fd41b4810a788d1626c2554181::suiiiiii {
    struct SUIIIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIIIII>(arg0, 6, b"SUIIIIII", b"SUIIIIIII", b"Meet Ronaldo's Famous SUIIIIIIIII on the SUI Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DD_7_EBF_14_F661_4_BEB_8_E40_580087646_F26_a1b2ea7f17.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIIIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

