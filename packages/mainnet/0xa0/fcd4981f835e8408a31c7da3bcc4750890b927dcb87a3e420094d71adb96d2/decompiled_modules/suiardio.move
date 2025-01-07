module 0xa0fcd4981f835e8408a31c7da3bcc4750890b927dcb87a3e420094d71adb96d2::suiardio {
    struct SUIARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIARDIO>(arg0, 6, b"Suiardio", b"SUIARDIO", b"suiardio to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DKJX_2398_a3de2d4b61_2cea12aa3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

