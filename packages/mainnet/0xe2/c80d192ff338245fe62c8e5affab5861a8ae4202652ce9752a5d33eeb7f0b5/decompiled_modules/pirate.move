module 0xe2c80d192ff338245fe62c8e5affab5861a8ae4202652ce9752a5d33eeb7f0b5::pirate {
    struct PIRATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRATE>(arg0, 6, b"PIRATE", b"Pirate of Sui", b"Set sail on the high seas of the Sui Network with $PIRATE! Embrace adventure and hunt for treasure. Arrr, matey!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_26_3e61a6eacf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIRATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

