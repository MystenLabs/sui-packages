module 0x352a1b63364c3a09fa73870cee885bbd7ad5db9834cc381c4d8bebf5abab0e53::flappy {
    struct FLAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAPPY>(arg0, 6, b"Flappy", b"The reborn of Flappy on Sui", b"Flappy Bird - Fully On Chain Gaming On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Flappy_Bird_icon_2aed2cc3ea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

