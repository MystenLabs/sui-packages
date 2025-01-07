module 0x16e84aa4174898d7d8d4aa7ace98533598daa6a2d12155ace11bdb8b55c8e04c::gosun {
    struct GOSUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOSUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOSUN>(arg0, 6, b"GOSUN", b"GUARDIAN OF SUN", x"475541524449414e204f462053554e200a54686973206d6f76656d656e742061696d7320746f2070726573657276652c2063656c6562726174652c202620636f6c6c61626f7261746520737570706f72742074686520637265617469766520616e642063756c747572616c207068656e6f6d656e6f6e206f66206d656d6573206f6e2054726f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logocover1_f359002d3a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOSUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOSUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

