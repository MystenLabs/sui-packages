module 0xa9e4bc4c1768cb035f64863788eea357f55a6ded3f57d17d40515c5291a3defa::ndog {
    struct NDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NDOG>(arg0, 6, b"NDOG", b"Nothing Dog", b"Nothing, just nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asd_a49b251023.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

