module 0xbf6a35ef031aa1961e49b98c91ae05852d5e60969a7000b1eb376c22fc380040::pms {
    struct PMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PMS>(arg0, 6, b"PMS", b"PACMANSUI", b"\"Are you ready for a race? Let's run with Pacman !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/loglo_a6d62374ef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

