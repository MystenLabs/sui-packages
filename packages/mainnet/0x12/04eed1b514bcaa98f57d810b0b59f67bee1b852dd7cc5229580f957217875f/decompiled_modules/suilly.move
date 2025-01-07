module 0x1204eed1b514bcaa98f57d810b0b59f67bee1b852dd7cc5229580f957217875f::suilly {
    struct SUILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILLY>(arg0, 6, b"SUILLY", b"Suilly", b"Sully + SUI = Suilly from Monsters Inc.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suilly_logo_6b1c777995.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

