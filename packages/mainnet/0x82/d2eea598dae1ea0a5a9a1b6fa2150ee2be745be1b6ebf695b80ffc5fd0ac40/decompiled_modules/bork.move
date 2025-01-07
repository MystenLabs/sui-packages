module 0x82d2eea598dae1ea0a5a9a1b6fa2150ee2be745be1b6ebf695b80ffc5fd0ac40::bork {
    struct BORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORK>(arg0, 6, b"BORK", b"BORK SUI", b"The only Martian created by Matt Furie.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_34_97f0a5aaf0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

