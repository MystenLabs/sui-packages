module 0x7f25d6e52cc48125da0ec8197daf4c288da229e9ad2989642cda2e86c2c2863f::am {
    struct AM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AM>(arg0, 9, b"AM", b"Amana", b"Best coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01c60c92-5f34-442e-bf51-07a2927bf252.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AM>>(v1);
    }

    // decompiled from Move bytecode v6
}

