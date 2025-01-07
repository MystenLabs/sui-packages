module 0x58755f50516aa45acc0074cd87d47bb0d4807a2ed75563c1f8090ac6781c93df::misty {
    struct MISTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISTY>(arg0, 6, b"MISTY", b"Misty On Sui", b"We're thrilled to have you with us as we kick off the $MISTY journey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f_VKZK_2_CI_400x400_957e6a99e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MISTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

