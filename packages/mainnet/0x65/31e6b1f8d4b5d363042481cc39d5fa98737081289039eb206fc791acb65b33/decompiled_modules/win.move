module 0x6531e6b1f8d4b5d363042481cc39d5fa98737081289039eb206fc791acb65b33::win {
    struct WIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIN>(arg0, 6, b"WIN", b"Sui Bag Casino", b"Casino games for the Sui blockchain. Website is live", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bag_30ddf609b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

