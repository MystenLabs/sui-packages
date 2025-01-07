module 0xf3b42c764756ce94852933d981c547eb6eede27298326c63a968aabe05bd5c02::baby {
    struct BABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABY>(arg0, 9, b"BABY", b"Baby Sui", x"54686520637574657320436f696e206f6e2053554920f09f91b6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844432426656825360/QbwxXeYh_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABY>>(v1);
    }

    // decompiled from Move bytecode v6
}

