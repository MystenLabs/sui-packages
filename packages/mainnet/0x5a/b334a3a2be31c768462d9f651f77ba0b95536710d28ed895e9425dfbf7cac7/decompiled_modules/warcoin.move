module 0x5ab334a3a2be31c768462d9f651f77ba0b95536710d28ed895e9425dfbf7cac7::warcoin {
    struct WARCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARCOIN>(arg0, 9, b"WARCOIN", b"WAR", b"Coin of the WAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d7f9312-6fdf-4a19-aaf6-f4681b3ae630.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WARCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

