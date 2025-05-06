module 0x476ac30457823256b446378e99fa96352ff2b63f372086960a87327262d7f85e::gork {
    struct GORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GORK>(arg0, 6, b"Gork", b"gork", b"just gorkin it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0797_ced0011962.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

