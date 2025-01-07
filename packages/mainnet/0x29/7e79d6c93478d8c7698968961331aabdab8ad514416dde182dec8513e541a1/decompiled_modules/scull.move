module 0x297e79d6c93478d8c7698968961331aabdab8ad514416dde182dec8513e541a1::scull {
    struct SCULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCULL>(arg0, 6, b"SCULL", b"Sui Scull", b"$SCULL is a long-term project that prioritizes innovation and future usability", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241001_135107_a70e0d2871.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

