module 0xe0604f7fb80a44e8ceb80a56c6a21aa8b5c13f1db2cdaca8cefcd9ec87aea09f::weewe {
    struct WEEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEEWE>(arg0, 9, b"WEEWE", b"WEE", b"WWWW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/392bf846-7acf-48db-81e0-b5fe43265a93.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

