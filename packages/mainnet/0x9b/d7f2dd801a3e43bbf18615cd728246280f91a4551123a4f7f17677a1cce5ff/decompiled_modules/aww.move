module 0x9bd7f2dd801a3e43bbf18615cd728246280f91a4551123a4f7f17677a1cce5ff::aww {
    struct AWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWW>(arg0, 6, b"AWW", b"r/aww", b"https://www.reddit.com/r/aww/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aww_02d1744180.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AWW>>(v1);
    }

    // decompiled from Move bytecode v6
}

