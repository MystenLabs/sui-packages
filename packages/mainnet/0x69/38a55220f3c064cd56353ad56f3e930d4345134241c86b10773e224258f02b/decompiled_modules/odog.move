module 0x6938a55220f3c064cd56353ad56f3e930d4345134241c86b10773e224258f02b::odog {
    struct ODOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODOG>(arg0, 6, b"ODOG", b"OOO Dog", b"OOO Dog - The Most Bullish Dog in Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OOODOG_e3cabebe3f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ODOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

