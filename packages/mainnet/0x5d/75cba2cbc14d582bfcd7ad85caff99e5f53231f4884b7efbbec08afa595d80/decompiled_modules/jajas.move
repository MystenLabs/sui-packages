module 0x5d75cba2cbc14d582bfcd7ad85caff99e5f53231f4884b7efbbec08afa595d80::jajas {
    struct JAJAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAJAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAJAS>(arg0, 9, b"JAJAS", b"JAJAW", b"JAJAJAJAJJAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf85e574-64d5-4188-9da6-ba1ae5a759bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAJAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAJAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

