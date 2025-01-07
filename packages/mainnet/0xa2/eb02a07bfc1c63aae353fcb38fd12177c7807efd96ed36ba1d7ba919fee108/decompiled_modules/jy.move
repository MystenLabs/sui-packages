module 0xa2eb02a07bfc1c63aae353fcb38fd12177c7807efd96ed36ba1d7ba919fee108::jy {
    struct JY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JY>(arg0, 9, b"JY", b"Joy", b"Joy is coming ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/138ab183-b8b3-4ff2-9c09-7b73590ee089.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JY>>(v1);
    }

    // decompiled from Move bytecode v6
}

