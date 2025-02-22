module 0xb75c0aa794e42fb83bd365b961a94e6f3fb3df833ab50a64f0ad0c508bc13fc9::okay {
    struct OKAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKAY>(arg0, 6, b"OKAY", b"I'M Okay", b"might be slow, but it's OKAYfuture millionaire in the making!  ,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000067061_a7f1f51dbe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OKAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

