module 0x13642b939ddd2fa6c66f294c0169c934301cd5aea2b194d5c4fc42c384c30906::dtrump {
    struct DTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTRUMP>(arg0, 6, b"DTRUMP", b"DogTrump", x"446f675472756d703a20426967206261726b732c20626f6c64206d6f7665732c20616e64206d656d652067726561746e6573732e204d616b696e672074686520646f67686f75736520677265617420616761696e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736890188048.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DTRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTRUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

