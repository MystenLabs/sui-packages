module 0xe04aa48b90a7a5d0c002210956cd5aa2a962969523a1eedab628414ea9928bed::sir {
    struct SIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIR>(arg0, 6, b"SIR", b"Sui sir", b"Drop sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029059_59d575bda1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

