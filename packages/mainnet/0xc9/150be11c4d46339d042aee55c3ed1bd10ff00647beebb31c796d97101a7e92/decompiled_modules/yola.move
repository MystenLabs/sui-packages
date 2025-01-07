module 0xc9150be11c4d46339d042aee55c3ed1bd10ff00647beebb31c796d97101a7e92::yola {
    struct YOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOLA>(arg0, 9, b"YOLA", b"Yolawa", b"Special meme for special users", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2e9db4e3-98c8-4617-954a-3e24f9a9af83.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

