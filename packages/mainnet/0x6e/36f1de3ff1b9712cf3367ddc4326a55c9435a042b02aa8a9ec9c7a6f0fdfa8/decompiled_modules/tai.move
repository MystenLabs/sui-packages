module 0x6e36f1de3ff1b9712cf3367ddc4326a55c9435a042b02aa8a9ec9c7a6f0fdfa8::tai {
    struct TAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAI>(arg0, 6, b"TAI", b"Tailmon on Sui Original", b"The first Tailmon on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1_6_5e89cd3187.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

