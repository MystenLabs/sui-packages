module 0x9ea6a31d8cdd37389d562e93482018d2cb4d4bfd0e8639999f3a9f5afb2550fe::Trolly {
    struct TROLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLLY>(arg0, 9, b"LOLTROL", b"Trolly", b"trollllly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gy91RyDWcAAlQXs?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROLLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

