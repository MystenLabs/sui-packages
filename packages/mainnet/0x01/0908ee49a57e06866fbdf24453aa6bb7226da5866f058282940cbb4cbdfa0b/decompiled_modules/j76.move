module 0x10908ee49a57e06866fbdf24453aa6bb7226da5866f058282940cbb4cbdfa0b::j76 {
    struct J76 has drop {
        dummy_field: bool,
    }

    fun init(arg0: J76, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<J76>(arg0, 9, b"J76", b"y7ku", b"dfygi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/baed035e52813e4af98f51e05b735206blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<J76>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<J76>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

