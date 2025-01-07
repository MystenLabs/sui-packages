module 0xb8b32c2b579287ebd9f26c362729801c7964f87d32876350b0f251159d5163ea::kitko {
    struct KITKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITKO>(arg0, 6, b"Kitko", b"Mr.Kitko", b"We are cooking for trend on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033461_d422e137f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KITKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

