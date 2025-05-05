module 0xab5c9124a7a80bb4334f4e5542b82c2526aba001259eaff2a6417979e89e975f::eskimo {
    struct ESKIMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESKIMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESKIMO>(arg0, 6, b"ESKIMO", b"DOGGY", b"My dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieol5keohfhf5yunbj2n7cqb5iobyftat5af6n2kmkv5xeixigdui")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESKIMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ESKIMO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

