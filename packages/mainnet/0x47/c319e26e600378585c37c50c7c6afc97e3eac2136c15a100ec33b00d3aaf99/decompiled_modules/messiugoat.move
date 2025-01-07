module 0x47c319e26e600378585c37c50c7c6afc97e3eac2136c15a100ec33b00d3aaf99::messiugoat {
    struct MESSIUGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESSIUGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MESSIUGOAT>(arg0, 6, b"MESSIUGOAT", b"MESSIU", b"Official token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/messssii_7b19f6d590.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MESSIUGOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MESSIUGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

