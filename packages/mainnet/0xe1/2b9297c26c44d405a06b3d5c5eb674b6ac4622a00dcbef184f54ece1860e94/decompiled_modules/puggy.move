module 0xe12b9297c26c44d405a06b3d5c5eb674b6ac4622a00dcbef184f54ece1860e94::puggy {
    struct PUGGY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PUGGY>, arg1: 0x2::coin::Coin<PUGGY>) {
        0x2::coin::burn<PUGGY>(arg0, arg1);
    }

    fun init(arg0: PUGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGGY>(arg0, 7, b"PUGGY", b"PuggyDog", b"$Puggy, the beloved star of Sui Network, is renowned for her infectious joy and endearing wrinkles.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/wWDNyaX.jpeg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUGGY>>(v1);
        0x2::coin::mint_and_transfer<PUGGY>(&mut v2, 3200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGGY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

