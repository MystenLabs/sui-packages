module 0x4fa08ebe584561dee61c778ce64a7dadc22f08c36262d3fc7d3f063556f5ee33::hjiff {
    struct HJIFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HJIFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HJIFF>(arg0, 6, b"HJIFf", b"Jiff Pom Hat", b"This is a CTO, inheriting Jiffpom's will and hoping that its happy appearance will heal everyone in The world. There is no cabal, nothing. Social experiment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2847_44e63ffa68.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HJIFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HJIFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

