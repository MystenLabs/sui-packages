module 0xe04bca7fba0af15bc66fff861d43e9b4a4dc2ffd4378c8ce59c1ec75200af487::moh {
    struct MOH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MOH>(arg0, 6, b"MOH", b"Mohamed", b"a generous and loyal friend ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/mohamed_ia_4a24cebcac.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

