module 0x328bfe04bf4d4a636adfa6484b5b359f3950b4565d79f228e998aa8c9366e1b6::ssk {
    struct SSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSK>(arg0, 6, b"SSK", b"Suick", b"The $SUI is here to make all others Sick.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_01_002710_3fcc845748.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

