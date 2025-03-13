module 0x9c139e5323a642eab7c70e4d5c9a6d057bbec69dcb16eb971c952b1caff68a2a::trumph {
    struct TRUMPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPH>(arg0, 6, b"TRUMPH", b"trumph", b"This is Trumph token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmT9H3oKQ6GWew2fy8RjtvsQAQofNZs562FfU432BtUxv8/trumph.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

