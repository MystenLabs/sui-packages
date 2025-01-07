module 0xe4f1ae65330ae25780da304970a5d3d981ba4d951fd49c50163e36b4174765a0::catcute {
    struct CATCUTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATCUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATCUTE>(arg0, 9, b"CATCUTE", b"Cat", b"My cat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/60cba056-c981-4dfc-a7b6-d78da55f77b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATCUTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATCUTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

