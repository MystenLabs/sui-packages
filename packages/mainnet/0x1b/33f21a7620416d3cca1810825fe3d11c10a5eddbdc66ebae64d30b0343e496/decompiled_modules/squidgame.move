module 0x1b33f21a7620416d3cca1810825fe3d11c10a5eddbdc66ebae64d30b0343e496::squidgame {
    struct SQUIDGAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDGAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDGAME>(arg0, 8, b"SQUIDGame", b"SQUID Game Coin", b"SQUID Game on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/1f58d2a7-d24e-4805-a128-f2b68f58cac0.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SQUIDGAME>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDGAME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIDGAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

