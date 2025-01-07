module 0x909828a477be9a49046f88a072e54278128e15930480bb076152c5f5c9a05956::blank {
    struct BLANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLANK>(arg0, 9, b"blank", x"e2a080", b"a coin based on nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.savageuniversal.com/media/catalog/product/cache/b957c6da7b66a4418290e73ac836efb5/b/a/backgrounds-savage-vinyl-backgrounds-sa-v20-01.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLANK>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLANK>>(v2, @0x5d9513165d55c3b90318c1dd2c4f0b9d1a0bdc90f9dddf6212b296294fac179c);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

