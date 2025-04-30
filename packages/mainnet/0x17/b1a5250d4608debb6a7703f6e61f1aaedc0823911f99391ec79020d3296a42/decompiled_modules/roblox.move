module 0x17b1a5250d4608debb6a7703f6e61f1aaedc0823911f99391ec79020d3296a42::roblox {
    struct ROBLOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBLOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBLOX>(arg0, 6, b"Roblox", b"MOONBLOX", b"just a moonbags token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaaqnqpdsdjrhr44op4hupxqjrjgqk25i4vk2dtx4utpbqfchqo3q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBLOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROBLOX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

