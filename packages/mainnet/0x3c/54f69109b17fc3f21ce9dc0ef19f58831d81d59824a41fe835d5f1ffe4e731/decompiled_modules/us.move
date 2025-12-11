module 0x3c54f69109b17fc3f21ce9dc0ef19f58831d81d59824a41fe835d5f1ffe4e731::us {
    struct US has drop {
        dummy_field: bool,
    }

    fun init(arg0: US, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<US>(arg0, 9, b"US", b"Talus Token", b"The native token for the Talus Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://talus.network/us-icon.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<US>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<US>>(0x2::coin::mint<US>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<US>>(v2);
    }

    // decompiled from Move bytecode v6
}

