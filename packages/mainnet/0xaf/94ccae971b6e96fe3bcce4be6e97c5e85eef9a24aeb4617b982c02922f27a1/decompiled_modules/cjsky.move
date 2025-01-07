module 0xaf94ccae971b6e96fe3bcce4be6e97c5e85eef9a24aeb4617b982c02922f27a1::cjsky {
    struct CJSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CJSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CJSKY>(arg0, 8, b"CJSKY", b"cjsky", b"CJSKY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreidxafmelx4leds5kgqwwxvkapageyq4tf7f74k2nw4nkz4wbgwzqy?X-Algorithm=PINATA1&X-Date=1733170513&X-Expires=315360000&X-Method=GET&X-Signature=3baa4cb3676a432b7fdbed06740c4e5ba332406b96607b68a5fd0faf09b0bc3b"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CJSKY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CJSKY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CJSKY>>(v2);
    }

    // decompiled from Move bytecode v6
}

