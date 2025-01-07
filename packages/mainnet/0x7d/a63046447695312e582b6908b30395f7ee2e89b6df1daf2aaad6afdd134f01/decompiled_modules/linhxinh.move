module 0x7da63046447695312e582b6908b30395f7ee2e89b6df1daf2aaad6afdd134f01::linhxinh {
    struct LINHXINH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LINHXINH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LINHXINH>(arg0, 9, b"LINHXINH", b"LePhan", b"A girl with beautiful smile", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/24eebd18-c4c5-48b2-8013-7965dc42fb1f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LINHXINH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LINHXINH>>(v1);
    }

    // decompiled from Move bytecode v6
}

