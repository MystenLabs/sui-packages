module 0x1bb5d67f83d2ed4776e85451b88c309f830069f7cf2b54a8570b0d0a6cd7d285::whoop {
    struct WHOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHOOP>(arg0, 6, b"Whoop", b"Whooptober", x"5570746f62657220697320636f6d696e67202d20776520676f6e6e612076696265207468697320746f20746865206d6f6f6e2e0a0a43616e20692067657420612077686f6f702077686f6f70", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_24e495db39.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

