module 0xba1f1cbda5970804e8ceb610308394326056176a66d1d828849cf1e64520fff1::mrwitchcat {
    struct MRWITCHCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRWITCHCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRWITCHCAT>(arg0, 6, b"MRWITCHCAT", b"Mr Witchcat", b"Mr Witchcat ready for halloween ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031398_f4c493a7e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRWITCHCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRWITCHCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

