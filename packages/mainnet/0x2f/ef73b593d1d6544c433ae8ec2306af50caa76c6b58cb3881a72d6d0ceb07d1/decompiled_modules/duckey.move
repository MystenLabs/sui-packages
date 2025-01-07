module 0x2fef73b593d1d6544c433ae8ec2306af50caa76c6b58cb3881a72d6d0ceb07d1::duckey {
    struct DUCKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKEY>(arg0, 6, b"DUCKEY", b"DUCKEYS", b"SAFE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_18_22_50_16_ba2f76d4e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

