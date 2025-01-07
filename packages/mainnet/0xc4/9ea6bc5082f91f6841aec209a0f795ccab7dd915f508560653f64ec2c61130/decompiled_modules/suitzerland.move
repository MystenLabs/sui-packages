module 0xc49ea6bc5082f91f6841aec209a0f795ccab7dd915f508560653f64ec2c61130::suitzerland {
    struct SUITZERLAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITZERLAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITZERLAND>(arg0, 6, b"SUITZERLAND", b"Suitzerland", b"A land flowing with milk and honey. Now on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241003_WA_0049_92d96c47f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITZERLAND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITZERLAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

