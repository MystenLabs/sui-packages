module 0x62b18ac711caca7f061e2f69e54dcd0ed900f08fdf1cfe941ccc725dcaf8c20a::cati {
    struct CATI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATI>(arg0, 6, b"CATI", b"Cati", b"a cute cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0485_bf8326b79c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATI>>(v1);
    }

    // decompiled from Move bytecode v6
}

