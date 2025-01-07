module 0x460e17182eb77d994d941c8263e2dbd85211cb0b38379d7433371084f9c0eb3e::fartcoin {
    struct FARTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTCOIN>(arg0, 6, b"Fartcoin", b"Fartcoin On Sui", b"Tokenising farts with the help of bots.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735083809990.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FARTCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

