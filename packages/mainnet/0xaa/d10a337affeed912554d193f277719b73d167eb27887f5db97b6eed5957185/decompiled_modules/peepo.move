module 0xaad10a337affeed912554d193f277719b73d167eb27887f5db97b6eed5957185::peepo {
    struct PEEPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEPO>(arg0, 6, b"PEEPO", b"PEEPO ON SUI", x"504545504f204f4e20535549204c495645204e4f5721200a0a68747470733a2f2f6b6e6f77796f75726d656d652e636f6d2f6d656d65732f706565706f2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9113_025324b78d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEEPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

