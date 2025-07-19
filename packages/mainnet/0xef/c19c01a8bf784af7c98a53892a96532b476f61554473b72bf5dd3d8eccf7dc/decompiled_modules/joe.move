module 0xefc19c01a8bf784af7c98a53892a96532b476f61554473b72bf5dd3d8eccf7dc::joe {
    struct JOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOE>(arg0, 6, b"JOE", b"My Name is Joesui", b"Hello my name is Joesui, some call me $JOE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeia7gwxuenkxdxhupmiawdwnrehkvx6arq2haf2dplpe75ir3mvwlq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

