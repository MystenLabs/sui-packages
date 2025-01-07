module 0xa85d045da88378fe24aaa220f2a6e71e63d94da251af2b2fc99755daf5f2692a::nobgob {
    struct NOBGOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOBGOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOBGOB>(arg0, 6, b"NOBGOB", b"KNOB GOBBLER BY MATT FURIE", b"KNOB GOBBLER by Matt Furie - the naughtiest of all the HEDZ characters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jnobr_61f0f7c9b8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOBGOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOBGOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

