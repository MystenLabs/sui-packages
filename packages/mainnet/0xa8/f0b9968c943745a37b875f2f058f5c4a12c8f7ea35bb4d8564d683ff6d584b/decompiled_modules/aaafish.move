module 0xa8f0b9968c943745a37b875f2f058f5c4a12c8f7ea35bb4d8564d683ff6d584b::aaafish {
    struct AAAFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAFISH>(arg0, 6, b"AAAFISH", b"aaafish", b"Can't stop won't stop being a fish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaafish_842acf5d95.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

