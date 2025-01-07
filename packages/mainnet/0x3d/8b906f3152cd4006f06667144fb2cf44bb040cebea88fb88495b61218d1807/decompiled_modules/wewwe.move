module 0x3d8b906f3152cd4006f06667144fb2cf44bb040cebea88fb88495b61218d1807::wewwe {
    struct WEWWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWWE>(arg0, 9, b"WEWWE", b"Memes", b"Dkkdjdkxkkx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/68617231-7044-46f9-bb34-2772a996cd19.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

