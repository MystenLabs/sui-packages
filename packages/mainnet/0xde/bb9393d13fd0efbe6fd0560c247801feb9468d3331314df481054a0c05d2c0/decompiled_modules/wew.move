module 0xdebb9393d13fd0efbe6fd0560c247801feb9468d3331314df481054a0c05d2c0::wew {
    struct WEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEW>(arg0, 9, b"WEW", b"WEWE", b"this token meme comunity form sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c27806b0-e7a3-4cf8-9acf-c3b7678c1d1e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

