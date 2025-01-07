module 0x222a4d56dbf45932f3c7e3edb4ff1ef617fc20ae6d673fa051b258afdc16a14e::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"TEST", b"test", b"This is a test deploy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreidxafmelx4leds5kgqwwxvkapageyq4tf7f74k2nw4nkz4wbgwzqy?X-Algorithm=PINATA1&X-Date=1733242250&X-Expires=315360000&X-Method=GET&X-Signature=7259469c786cb6f88b3e0af40cb6fd761f3b84615d660b192bd6e1b5fc9c145b"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST>>(v2);
    }

    // decompiled from Move bytecode v6
}

