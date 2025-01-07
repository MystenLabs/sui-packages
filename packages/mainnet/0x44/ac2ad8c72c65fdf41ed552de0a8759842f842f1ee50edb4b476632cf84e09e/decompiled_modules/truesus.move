module 0x44ac2ad8c72c65fdf41ed552de0a8759842f842f1ee50edb4b476632cf84e09e::truesus {
    struct TRUESUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUESUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUESUS>(arg0, 6, b"TRUESUS", b"TRUMP IS JESUS", b"Believe me, nobody does miracles better than me. We're going to turn water into wine, and it's going to be the best wine, the finest wine. And let me tell you, we're going to heal the sick, and it's going to be tremendous. We're going to make the blind see, going to be huge.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Skjermbilde_2024_10_27_kl_08_11_55_c6ef5bac00.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUESUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUESUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

