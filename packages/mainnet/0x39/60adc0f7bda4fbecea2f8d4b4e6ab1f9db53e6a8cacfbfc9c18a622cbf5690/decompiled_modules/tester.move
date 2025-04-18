module 0x3960adc0f7bda4fbecea2f8d4b4e6ab1f9db53e6a8cacfbfc9c18a622cbf5690::tester {
    struct TESTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTER>(arg0, 6, b"Tester", b"Test", b"Test don't buy plz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeianbaffiwkggzrjei2ttpd3r766lconhapskn4sapqyrxbmjdxgzy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

