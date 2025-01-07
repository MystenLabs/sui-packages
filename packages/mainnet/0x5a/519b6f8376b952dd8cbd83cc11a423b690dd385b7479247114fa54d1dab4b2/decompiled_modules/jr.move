module 0x5a519b6f8376b952dd8cbd83cc11a423b690dd385b7479247114fa54d1dab4b2::jr {
    struct JR has drop {
        dummy_field: bool,
    }

    fun init(arg0: JR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JR>(arg0, 9, b"JR", b"Jordan", b"Jordan Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JR>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JR>>(v1);
    }

    // decompiled from Move bytecode v6
}

