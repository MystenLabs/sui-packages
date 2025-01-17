module 0xfce8d95d519ccbfb9e78c8fc7d12b4ecc32f8add6aa0ef38fbe90d308279e203::gara {
    struct GARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARA>(arg0, 6, b"GARA", b"Gambling Rabbit", b"Join us if you like gambling in SUI! LFGGGGG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3102_9e304cb9f9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

