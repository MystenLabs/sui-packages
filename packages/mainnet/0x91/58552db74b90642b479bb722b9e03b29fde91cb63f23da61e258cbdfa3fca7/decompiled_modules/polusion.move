module 0x9158552db74b90642b479bb722b9e03b29fde91cb63f23da61e258cbdfa3fca7::polusion {
    struct POLUSION has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLUSION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLUSION>(arg0, 9, b"POLUSION", b"POLUSi", b"Earth free Polusi ecossystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/125d0639-9dc5-429a-a45a-79a71b557bbb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLUSION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POLUSION>>(v1);
    }

    // decompiled from Move bytecode v6
}

