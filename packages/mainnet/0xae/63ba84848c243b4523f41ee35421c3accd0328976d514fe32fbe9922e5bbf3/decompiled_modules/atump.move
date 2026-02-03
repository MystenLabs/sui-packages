module 0xae63ba84848c243b4523f41ee35421c3accd0328976d514fe32fbe9922e5bbf3::atump {
    struct ATUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATUMP>(arg0, 6, b"ATUMP", b"AKHI TRUMP", x"53696e636520746865204570737465696e2066696c65732064726f707065642c0a416b6869205472756d702068617320726570656e746564", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0899_376a237c32.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

