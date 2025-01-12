module 0x4c7ef1486dc458888adbdce7b86125841f81b4307508bd6549f1b8b56791df00::zssui {
    struct ZSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZSSUI>(arg0, 6, b"ZSSUI", b"Alex Becker Meme", b"Alex Becker Meme on Sui and Solana Networks, 100% Commitment, 100% Liquidity Burned, 100% Community Focused, Mint Revoked, 100% Liquidity Burned ALEX BECKER MEME for the community. Alex Becker is an online marketer, entrepreneur, founder of NeoTokyo ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736703856551.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZSSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZSSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

