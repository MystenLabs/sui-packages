module 0xff3de9e210cc220621fd2c004c68354a324a4bb2ddd9cf1a9c87658a6d02ef51::abc {
    struct ABC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABC>(arg0, 9, b"abc", b"abc", b"abacabac", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ABC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABC>>(v1);
    }

    // decompiled from Move bytecode v6
}

