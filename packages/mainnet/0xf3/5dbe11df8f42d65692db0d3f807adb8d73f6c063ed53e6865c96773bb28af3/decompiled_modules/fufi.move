module 0xf35dbe11df8f42d65692db0d3f807adb8d73f6c063ed53e6865c96773bb28af3::fufi {
    struct FUFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUFI>(arg0, 6, b"FUFI", b"Fuck Fish", b"Fuck Fish on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fufi_5e4ed8fe0d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

