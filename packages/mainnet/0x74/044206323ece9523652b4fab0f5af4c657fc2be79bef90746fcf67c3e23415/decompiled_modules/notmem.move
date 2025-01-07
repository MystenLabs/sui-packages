module 0x74044206323ece9523652b4fab0f5af4c657fc2be79bef90746fcf67c3e23415::notmem {
    struct NOTMEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTMEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTMEM>(arg0, 9, b"NOTMEM", b"NOTME", b"Your path to success", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2ff8f54-1dbb-4ff1-a76a-deda65c72659.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTMEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOTMEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

