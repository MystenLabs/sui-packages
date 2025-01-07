module 0xe50401be6f1a1b0bf084537ddab569482c8bcba86cf731d7609935b579f27a03::nar {
    struct NAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAR>(arg0, 6, b"NAR", b"Sui Narwhal", b"An adorably oblivious narwhal who's always making waves in the deep sea, riding through chaos with a goofy grin! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/whale_8fa66f3ae8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

