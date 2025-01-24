module 0x5278b6ce7d118101f3e91ab11ef54408cff424b1edc006fb8954274364607c17::swag {
    struct SWAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWAG>(arg0, 6, b"SWAG", b"Swag", b"Own the swag ! Rule the trend !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046921_1f982c486d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

