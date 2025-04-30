module 0xc393a471d2f3dfe6703f586063b8f72add5c37f7c24425a16a7eeb1afcff0c0b::GORILLA {
    struct GORILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GORILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GORILLA>(arg0, 6, b"GORILLA", b"Gorilla", b"1 gorilla or 100 man?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmbFyrVCeHHt3qUwhSre3bmhvDX7F3nExah2XFhxw8sGpJ")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GORILLA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GORILLA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

