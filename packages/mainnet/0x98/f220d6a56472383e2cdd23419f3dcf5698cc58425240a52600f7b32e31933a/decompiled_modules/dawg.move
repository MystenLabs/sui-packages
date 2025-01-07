module 0x98f220d6a56472383e2cdd23419f3dcf5698cc58425240a52600f7b32e31933a::dawg {
    struct DAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAWG>(arg0, 6, b"DAWG", b"DAWG SUI", x"4c6567616c20446973636c61696d65723a2024444157472069732061206d656d6520636f696e2077697468206e6f20696e7472696e7369632076616c7565206f72206578706563746174696f6e206f662066696e616e6369616c2072657475726e2e205768656e20796f752070757263686173652024444157472c20796f7520617265206167726565696e67207468617420796f752068617665207365656e207468697320646973636c61696d65722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_23_09_08_7abb770a6c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

