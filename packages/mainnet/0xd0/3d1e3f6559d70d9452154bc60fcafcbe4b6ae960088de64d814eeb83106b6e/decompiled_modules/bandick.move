module 0xd03d1e3f6559d70d9452154bc60fcafcbe4b6ae960088de64d814eeb83106b6e::bandick {
    struct BANDICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANDICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANDICK>(arg0, 6, b"BANDICK", b"Ban Dick", b"\"Sui chain fair launch, are you ready, friends?\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3871_e6186ca84b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANDICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANDICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

