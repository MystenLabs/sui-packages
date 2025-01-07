module 0xc5a0127c3e01b72147fbd91fbef59adad7289c29bfd6fc9054df59b8b7dfc9f5::stronk {
    struct STRONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRONK>(arg0, 6, b"STRONK", b"Sui Stronk", b"Meet $STRONK. Powering up the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Stronk_72c760cf1c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

