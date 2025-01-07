module 0x475249eb25e5928d9f13f68689f066c71ada7664ecad160627ba7cd49c050fdb::wbmn {
    struct WBMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WBMN>(arg0, 9, b"WBMN", b"Wmb", b"This is new project in sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c6a997cc-99ef-4b05-8c90-7edaa9fdb614.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WBMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

