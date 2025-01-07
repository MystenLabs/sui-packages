module 0x4b1f0a8c4e41d0ab96057af4d95c69faa1f1457566beffa6a812ad99dc7d09a9::messui {
    struct MESSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MESSUI>(arg0, 6, b"MESSUI", b"Messui", x"54686520474f4154206f6e205375692e200a244d4553535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031290_be6db3c23e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MESSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MESSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

