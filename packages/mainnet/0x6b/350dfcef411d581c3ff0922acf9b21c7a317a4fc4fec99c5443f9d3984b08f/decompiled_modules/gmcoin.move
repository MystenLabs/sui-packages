module 0x6b350dfcef411d581c3ff0922acf9b21c7a317a4fc4fec99c5443f9d3984b08f::gmcoin {
    struct GMCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMCOIN>(arg0, 9, b"GMCOIN", b"GMC", b"Community token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1b541ae5-b133-4e5c-b89f-daf3be09f1c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GMCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

