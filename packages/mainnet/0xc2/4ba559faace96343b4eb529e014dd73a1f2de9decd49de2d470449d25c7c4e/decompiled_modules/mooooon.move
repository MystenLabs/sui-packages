module 0xc24ba559faace96343b4eb529e014dd73a1f2de9decd49de2d470449d25c7c4e::mooooon {
    struct MOOOOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOOOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOOOON>(arg0, 9, b"MOOOOON", b"TO THE MOON", b"To the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOOOOON>(&mut v2, 20000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOOOON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOOOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

