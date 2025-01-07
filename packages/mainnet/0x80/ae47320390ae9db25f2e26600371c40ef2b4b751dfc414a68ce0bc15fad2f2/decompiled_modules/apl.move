module 0x80ae47320390ae9db25f2e26600371c40ef2b4b751dfc414a68ce0bc15fad2f2::apl {
    struct APL has drop {
        dummy_field: bool,
    }

    fun init(arg0: APL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APL>(arg0, 9, b"APL", b"apolo", b"ok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d33236f1-3cd6-420f-b75a-f515bffbbe04.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APL>>(v1);
    }

    // decompiled from Move bytecode v6
}

