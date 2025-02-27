module 0x26e621aa74561d15f8a808e9e2225177a9f026d375c63ee51099586bd7ab681a::ali {
    struct ALI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALI>(arg0, 9, b"ALI", b"AliCoin", b"A coin for Ali", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ALI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALI>>(v1);
    }

    // decompiled from Move bytecode v6
}

