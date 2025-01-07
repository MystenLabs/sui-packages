module 0x20a67b0041881a15166a70718d94946c00d10132465dd1f4589f93c101ef2eab::cz {
    struct CZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZ>(arg0, 6, b"CZ", b"Changpeng.Zhao", b"Hello everyone, it's cz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_f5dc431b12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

