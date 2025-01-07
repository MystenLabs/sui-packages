module 0xaeaf302afa2f8d43f473c50735b83651805b588e5b1f406922aab85210ceb83b::frogs {
    struct FROGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGS>(arg0, 9, b"FROGS", b"Frogs sui", b"recreating the splendor of the bitcoin frogs collection on the BTC ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ece179bb-cbf1-4b6a-b6a5-75def4e0a223.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

