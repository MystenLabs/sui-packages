module 0x8a7f69ea91ff0c53f826a37454bdcb70db40874cf4eb81a19761d8021fe6d8da::ghal {
    struct GHAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHAL>(arg0, 6, b"GHAL", x"47686f73742048616c6c6f7765656e20f09f8e83", x"4a6f696e20746865207265766f6c7574696f6e20776974682047686f73742048616c6c6f7765656e2c2061206d656d6520746f6b656e206f6e207468652053554920626c6f636b636861696e2e20457870657269656e6365207265616c207574696c69747920616e642066756e206173207765207072657061726520746f206c61756e6368206f757220696e6e6f76617469766520706c6174666f726d2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730980035493.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

