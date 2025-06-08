module 0x23368b74bcccdba54153a9ab3fb6d662f5c1bec1e197e6417f303529e9281c1a::goh {
    struct GOH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOH>(arg0, 6, b"GOH", b"Van Gohmon", b"Designed by the legend Van Gogh himself", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeie7cpvad5kfsi6mkrcjfbng4mio3ayhcg4ph3zox7ymfaoc6ubyri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

