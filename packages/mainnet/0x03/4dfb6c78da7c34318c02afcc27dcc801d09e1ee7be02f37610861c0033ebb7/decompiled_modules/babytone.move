module 0x34dfb6c78da7c34318c02afcc27dcc801d09e1ee7be02f37610861c0033ebb7::babytone {
    struct BABYTONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYTONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYTONE>(arg0, 9, b"BABYTONE", b"Babyton", b"The first Babyton token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3fc1ab5c-bad9-4516-b7cc-1b579ba8bf67.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYTONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYTONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

