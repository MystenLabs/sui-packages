module 0xcb24c652d9a469e375fd0a89e4eb301124bb3c7c69d45e289760cd701a47d031::gos {
    struct GOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOS>(arg0, 6, b"GOS", b"God of Sui", b"God of Sui $GOS is an exciting Sui blockchain project offering rewards through engaging gameplay and unique finance features.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000062418_4bc995159d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

