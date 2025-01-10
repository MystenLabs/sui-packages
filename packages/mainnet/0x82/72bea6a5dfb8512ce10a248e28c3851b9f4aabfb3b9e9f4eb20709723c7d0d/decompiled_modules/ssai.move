module 0x8272bea6a5dfb8512ce10a248e28c3851b9f4aabfb3b9e9f4eb20709723c7d0d::ssai {
    struct SSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSAI>(arg0, 6, b"SSAI", b"Singularry Sui AI", b"The AI that wants to get a robot body and boink everything that moves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250111_002652_044_e7436ee168.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

