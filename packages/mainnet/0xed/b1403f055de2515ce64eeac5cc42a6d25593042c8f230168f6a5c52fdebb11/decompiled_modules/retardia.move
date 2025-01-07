module 0xedb1403f055de2515ce64eeac5cc42a6d25593042c8f230168f6a5c52fdebb11::retardia {
    struct RETARDIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETARDIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETARDIA>(arg0, 6, b"Retardia", b"Retardia on SUI", b"Join 'Bonny and Clyde' Treasury", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/retardia_184d4ab6fb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETARDIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RETARDIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

