module 0x9a35fb5625109c47944d263bd15b919a2d259f1704471b41d86ebf8863d750a9::pimeme {
    struct PIMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIMEME>(arg0, 9, b"PIMEME", x"506920cf80", b"Pi Network is a cryptocurrency platform that allows mobile users to mine Pi coins without draining their battery or harming the environment. It also enables developers to offer real-life utilities and products in exchange for Pi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d6c8b436-0cfe-4b21-b0db-3c1d367633ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

