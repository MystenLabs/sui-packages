module 0x45f20692d8bea4367e343c831e14e9f293ec90e6c9974949837e0b4ad746f1fe::u_wewe {
    struct U_WEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: U_WEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<U_WEWE>(arg0, 9, b"U_WEWE", b"UVwewe", b"Loading, up, rocket ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/20dfc8e3-e844-42d5-83aa-7785be868476.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<U_WEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<U_WEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

