module 0xa8460812e558d32e9e8e2d340096c79cedaef6fecb9e0a8f30338e2e138758ed::taddy {
    struct TADDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TADDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TADDY>(arg0, 6, b"Taddy", b"Tadpole", b"Taddy anon very Taddy much Sui and more Taddy. Taddy with Taddy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6379_6a3ebaf17b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TADDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TADDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

