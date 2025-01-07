module 0xa15f559029cb0f5822921a2c552ce2b5b42fda04271f8632f2650bbed01ad4be::ezgg {
    struct EZGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EZGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EZGG>(arg0, 6, b"ezGG", b"GG", b"Build meme in Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8218_363c724d1c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EZGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EZGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

