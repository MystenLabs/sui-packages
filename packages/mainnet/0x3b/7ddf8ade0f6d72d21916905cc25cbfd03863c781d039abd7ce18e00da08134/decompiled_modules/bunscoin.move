module 0x3b7ddf8ade0f6d72d21916905cc25cbfd03863c781d039abd7ce18e00da08134::bunscoin {
    struct BUNSCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNSCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNSCOIN>(arg0, 9, b"BUNSCOIN", b"Buns_coin", b"Sweet buns for real connoisseurs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8cdfc229-18d9-43a4-b65a-1b147befc2e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNSCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUNSCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

