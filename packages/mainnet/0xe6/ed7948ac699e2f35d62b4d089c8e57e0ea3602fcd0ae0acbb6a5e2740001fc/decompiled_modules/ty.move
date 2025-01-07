module 0xe6ed7948ac699e2f35d62b4d089c8e57e0ea3602fcd0ae0acbb6a5e2740001fc::ty {
    struct TY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TY>(arg0, 9, b"TY", b"ThankYou", b"Just Thanks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c85252f-8b66-4fcf-a398-0a3da8a063c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TY>>(v1);
    }

    // decompiled from Move bytecode v6
}

