module 0x52ce02b025d0d9b50e6dd6c83271f549939b60d96713952148146f4ee668f1c6::sun95ai {
    struct SUN95AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUN95AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUN95AI>(arg0, 9, b"Sun95ai", x"53554e2d39354149e280a443304d", b"Official sun coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.vecteezy.com/system/resources/previews/000/551/121/non_2x/vector-cartoon-sun.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUN95AI>(&mut v2, 95000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUN95AI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUN95AI>>(v1);
    }

    // decompiled from Move bytecode v6
}

