module 0x42b6bd76a8553d6339ccbd5049fe501939692c7e56428cb2fa1bff299899c6eb::suiky {
    struct SUIKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKY>(arg0, 6, b"SUIKY", b"Suiky", b"QUACK QUACK!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiky_ef4b50a743.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

