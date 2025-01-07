module 0xb7ce6d450c2e8a44fd59f52a841cd54fd08fd089f34f104e4ae1a763ea470030::duensn {
    struct DUENSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUENSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUENSN>(arg0, 9, b"DUENSN", b"Sgsjsj", b"Djdndnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/03304794-9a71-48e6-8b45-0738329a66ba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUENSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUENSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

