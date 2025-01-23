module 0x38df9a69560e014a79e228cda85f41df6771786002e6941228593228bc835e03::llll {
    struct LLLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLLL>(arg0, 1, b"LLLL", b"Listen Look & Listen", b"Listen, Look and Listen, and Learn! the truth will set me free", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/0119eda0-d98c-11ef-80e8-811f7f414973")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LLLL>>(v1);
        0x2::coin::mint_and_transfer<LLLL>(&mut v2, 11000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLLL>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

