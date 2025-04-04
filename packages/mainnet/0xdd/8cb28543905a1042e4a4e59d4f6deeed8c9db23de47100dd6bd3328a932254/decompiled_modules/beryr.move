module 0xdd8cb28543905a1042e4a4e59d4f6deeed8c9db23de47100dd6bd3328a932254::beryr {
    struct BERYR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERYR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERYR>(arg0, 9, b"BERYR", b"Newm", b"NEW MEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f73bffb8f6d7682db5ab52727ed15cf0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BERYR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERYR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

