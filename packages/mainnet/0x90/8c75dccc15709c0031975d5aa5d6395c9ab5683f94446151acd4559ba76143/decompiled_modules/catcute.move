module 0x908c75dccc15709c0031975d5aa5d6395c9ab5683f94446151acd4559ba76143::catcute {
    struct CATCUTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATCUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATCUTE>(arg0, 9, b"CATCUTE", b"Cat", b"My catcute", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/34d69374-b807-405c-a458-f0c8e57d1d67.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATCUTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATCUTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

