module 0xf35137aaef12aea28a8ac0144c3bb901f6d724086f07fd3d0d184bcbf758b383::boysclub {
    struct BOYSCLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOYSCLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOYSCLUB>(arg0, 6, b"BOYSCLUB", b"Boysclub on Sui", b"Where memes meet friendship in perfect harmony. Step into the world of Pepe, Andy, Brett, Bird Dog and Landwolf!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048530_9698abb4bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOYSCLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOYSCLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

