module 0x83f10a550f7e1a78047a17441aefc66886ca0bf5637865e1dcdd270e37398127::sucked {
    struct SUCKED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCKED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCKED>(arg0, 6, b"SUCKED", b"SUISEISOLANAROBERTJONSHON69W", x"46495253542043554c54204d454d45204f4e20535549200a594f552041524520474f54205355434b45442a0a544720414e44205457495454455220534f4f4e204f4e434520495420424f4e4445440a0a444f4e5420474554205355434b45440a0a4e4f20444556200a4e4f205445414d0a4a555354205355434b454420495420424142590a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1737_0e062aade0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCKED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUCKED>>(v1);
    }

    // decompiled from Move bytecode v6
}

