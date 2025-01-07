module 0x5aaa5eb90920e8813d9c547db3437b60d131f078463ce0a8e3e317675ff3f9fa::se_se {
    struct SE_SE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SE_SE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SE_SE>(arg0, 9, b"SE_SE", b"Sese", b"Its a memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/625a8d1a-c449-4dcc-aab7-cb5530b6a460.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SE_SE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SE_SE>>(v1);
    }

    // decompiled from Move bytecode v6
}

