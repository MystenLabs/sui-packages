module 0x21ebdb2f74d23ba9a8f17d210c6c669b4631e3b299707fda47e2418c6f91dd75::nova {
    struct NOVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOVA>(arg0, 6, b"USDT", b"Tether USD", b"USDT is a community token built on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/r2KnLhMH/USDT-Logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<NOVA>>(0x2::coin::mint<NOVA>(&mut v2, 800000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOVA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOVA>>(v1);
    }

    // decompiled from Move bytecode v7
}

