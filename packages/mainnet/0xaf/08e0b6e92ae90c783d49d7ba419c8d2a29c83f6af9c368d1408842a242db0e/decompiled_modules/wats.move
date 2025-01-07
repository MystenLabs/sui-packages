module 0xaf08e0b6e92ae90c783d49d7ba419c8d2a29c83f6af9c368d1408842a242db0e::wats {
    struct WATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATS>(arg0, 9, b"WATS", b"WATS CATS", b"WEWE CATSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1508649-5b38-4cb9-98c4-a495b05fdc69.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

