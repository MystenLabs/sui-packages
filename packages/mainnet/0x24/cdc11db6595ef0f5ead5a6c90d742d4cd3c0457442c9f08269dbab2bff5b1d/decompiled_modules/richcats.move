module 0x24cdc11db6595ef0f5ead5a6c90d742d4cd3c0457442c9f08269dbab2bff5b1d::richcats {
    struct RICHCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICHCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICHCATS>(arg0, 6, b"RICHCATS", b"RICHCAT$", b"RICHCAT$ is a Sui-based meme token designed to build a powerful community and foster connections in the crypto space. Join the pride and be part of a movement where success and growth are limitless!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734181849287.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICHCATS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICHCATS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

