module 0x4f7a45d1d3b24a95acd82f498fd71a1780847099c228623daf8696d7489304a8::strump {
    struct STRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRUMP>(arg0, 6, b"STRUMP", b"SmarTrump", b"If you smart person buy this token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicugzmh4ympzeac6pwnofsprt3uzzhddpvnsxqj7mv33mukktvepe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STRUMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

