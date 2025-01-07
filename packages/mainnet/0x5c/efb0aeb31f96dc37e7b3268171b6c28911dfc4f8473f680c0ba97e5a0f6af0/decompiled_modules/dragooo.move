module 0x5cefb0aeb31f96dc37e7b3268171b6c28911dfc4f8473f680c0ba97e5a0f6af0::dragooo {
    struct DRAGOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGOOO>(arg0, 9, b"DRAGOOO", b"DRAGOOO", b"DRAGO 123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdns-images.dzcdn.net/images/talk/7269c30dd78d2c65d6bf7086b584d4ee/0x1900-000000-80-0-0.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DRAGOOO>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGOOO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAGOOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

