module 0xf92816998726577d6bd11152210b930954f693cbfe2d602ba1a719e029d2678e::rugfun {
    struct RUGFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGFUN>(arg0, 6, b"Rugfun", b"HopFunRug", b"Rug all meme sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000071759_6d9d6473eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUGFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

