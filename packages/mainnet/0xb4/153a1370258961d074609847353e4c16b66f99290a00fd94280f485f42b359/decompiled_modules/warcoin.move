module 0xb4153a1370258961d074609847353e4c16b66f99290a00fd94280f485f42b359::warcoin {
    struct WARCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARCOIN>(arg0, 9, b"WARCOIN", b"WAR", b"Coin of the WAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/05e00f72-ba93-475d-82d6-ffff8099dd13.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WARCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

