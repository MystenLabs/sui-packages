module 0x507274a39c63f996825b5d1270fe444248ec0f59f9db7e2a5e73363cbf9e1b77::mahinoto {
    struct MAHINOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAHINOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAHINOTO>(arg0, 9, b"MAHINOTO", b"Mahan", b"Best love in people's ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9683fc41-76f3-4de1-8ce8-399146d27ddb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAHINOTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAHINOTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

