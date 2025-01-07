module 0x931b92a89c2af00edff624aa652256557d80f9da20c4098cf746d5647fe09ef::amber {
    struct AMBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMBER>(arg0, 6, b"AMBER", b"AMBER ON SUI", x"61206d656d65636f696e20666f72207468652070656f706c650a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/amber_089dbf51de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

