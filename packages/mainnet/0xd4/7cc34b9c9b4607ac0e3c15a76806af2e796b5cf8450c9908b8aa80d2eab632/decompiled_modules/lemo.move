module 0xd47cc34b9c9b4607ac0e3c15a76806af2e796b5cf8450c9908b8aa80d2eab632::lemo {
    struct LEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEMO>(arg0, 6, b"LEMO", b"LEMO on SUI", b"We rugged Jade. We killed a killer whale. Now we're doing the funniest thing ever. 100% locked. No sniper. 2% reserved for Jade. No tg for you fkers cause you are pricks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeig3fic4a2gecr6dttv4avcsxgnvcdkrq6rd22ryf7h6yeonstur2y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LEMO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

