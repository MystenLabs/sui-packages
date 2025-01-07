module 0x65d2dd9f63d76ed82615cf8e793ee72a7982431afbe5f57687f57a7f132ee7e4::jh {
    struct JH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JH>(arg0, 9, b"JH", b"R", b"JHH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/392097c8-4c88-42e2-96b5-5387aca34094.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JH>>(v1);
    }

    // decompiled from Move bytecode v6
}

