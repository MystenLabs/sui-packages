module 0xc19cbd09803a02482ff9a049882d40cf84aa4d7fbe00321f32ff5b9e02b4d951::kitko {
    struct KITKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITKO>(arg0, 6, b"Kitko", b"Mr.Kitko", b"We are cooking for sure ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033461_f9c30f3013.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KITKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

