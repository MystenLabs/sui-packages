module 0x2dd5d044e233fde87b9973af28b8a30f13caa78da14d5f2a16fb22d8195dcac3::mooonkey {
    struct MOOONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOONKEY>(arg0, 6, b"MOOONKEY", b"SUIMOONKEY", b"Unauthorized: Refresh token failed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiad3jgnletd4ixcwejaqu36c6t57elcz34bl3vngsdcpui3u3mmjy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOOONKEY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

