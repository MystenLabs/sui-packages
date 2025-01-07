module 0x533cf906f8fb6798302e23f54c8afea748c099806cfbdcf4635b6adca70f47f7::asuuu {
    struct ASUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASUUU>(arg0, 6, b"Asuuu", b"aaaa asuuu", b"asuasuasu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7011_adc42e5633.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASUUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASUUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

