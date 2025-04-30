module 0x8ab85b5bc226427b3a132d714e47cb837d577c4ad1ef6cdaf3664505718395fb::moonblox {
    struct MOONBLOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONBLOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONBLOX>(arg0, 6, b"MOONBLOX", b"ROBLOX", b"just a sui token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaaqnqpdsdjrhr44op4hupxqjrjgqk25i4vk2dtx4utpbqfchqo3q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONBLOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOONBLOX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

