module 0xad545bfe7743eeddfe83d03db6568f059a1fa48607b451402b7e53c21ffd78f2::Solana {
    struct SOLANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLANA>(arg0, 9, b"SOL", b"Solana", b"so la na", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/G0QyO1MXoAANsmb?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOLANA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLANA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

