module 0xabb8fe24bc808172af32ac1dd6f840a979401f6c91f6aaa4de6d1c799307162d::warcoin {
    struct WARCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARCOIN>(arg0, 9, b"WARCOIN", b"WAR", b"Coin of the WAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b964eeb-4117-4c01-b5e1-8a5b24226875.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WARCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

