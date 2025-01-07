module 0xbfc3c506ca44d7113c361f008395172c23de8ba72a046e9ce09699fa762ec07e::billi {
    struct BILLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLI>(arg0, 9, b"BILLI", b"Billion do", b"Awesome project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9685e4b4-54ef-41c1-bf9c-9d3906f8844e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BILLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

