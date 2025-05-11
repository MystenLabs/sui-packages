module 0x9ae8b466c8165d7c042586600d35eb4a22c581e4509837c968f58c4ea905529b::sgb {
    struct SGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGB>(arg0, 6, b"SGb", b"SiGmA Boy Sui", b"A true Sigma stacks and forgets. Moonbags only", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihkyr5ajfufgkbwumiani3x6l5kasu7kgftylnk57csfl5lldr3im")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SGB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

