module 0x73d494b13747ca31d305f15bb1638d4f51773e15ebd52216689506c98d298dc2::mmn {
    struct MMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMN>(arg0, 6, b"MMN", b"MOOMANOW", b"MooManow is a single small hippo in Kaokeaw.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_a_a_a_a_a_a_7ee61c28d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

