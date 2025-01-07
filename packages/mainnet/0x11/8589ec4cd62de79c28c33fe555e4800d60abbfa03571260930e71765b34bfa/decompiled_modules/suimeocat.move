module 0x118589ec4cd62de79c28c33fe555e4800d60abbfa03571260930e71765b34bfa::suimeocat {
    struct SUIMEOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEOCAT>(arg0, 9, b"SUIMEOCAT", b"Suimeo cat", b"Rizz cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bbd37061-0f0b-4f98-9878-8090b44a9f9c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMEOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

