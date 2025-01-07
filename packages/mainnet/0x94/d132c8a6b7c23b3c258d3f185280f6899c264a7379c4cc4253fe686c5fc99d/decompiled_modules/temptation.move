module 0x94d132c8a6b7c23b3c258d3f185280f6899c264a7379c4cc4253fe686c5fc99d::temptation {
    struct TEMPTATION has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPTATION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMPTATION>(arg0, 6, b"Temptation", b"Black Silk", b"Shoot the bullet hard ~", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012711_546a0ccc83.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPTATION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEMPTATION>>(v1);
    }

    // decompiled from Move bytecode v6
}

