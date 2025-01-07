module 0x6feb3664038be9765b33a0b8a01ae30c63e634c202939f584dbedc4a0d8f2216::bibi {
    struct BIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIBI>(arg0, 6, b"Bibi", b"Selfie Penguin", b"Play with BiBi on SUI, it spreads like a virus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/peng_435ff2a598.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

