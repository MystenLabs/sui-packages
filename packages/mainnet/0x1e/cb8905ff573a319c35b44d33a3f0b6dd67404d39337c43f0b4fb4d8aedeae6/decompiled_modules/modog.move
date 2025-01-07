module 0x1ecb8905ff573a319c35b44d33a3f0b6dd67404d39337c43f0b4fb4d8aedeae6::modog {
    struct MODOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MODOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MODOG>(arg0, 6, b"MODOG", b"Mother Dog", b"Popular meme MotherDog vibes Mom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/motherdog_logo_251a144b4e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MODOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MODOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

