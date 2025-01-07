module 0x883d0ac11384cacf40dd8974ba5ded7c2ffa0d1113124386ba62361b5f37405f::vevo {
    struct VEVO has drop {
        dummy_field: bool,
    }

    fun init(arg0: VEVO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VEVO>(arg0, 9, b"VEVO", b"Blink", b"Vevo gives you more insight into the web 3 activities ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4d81b846-2170-4c01-a950-958dea419776.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VEVO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VEVO>>(v1);
    }

    // decompiled from Move bytecode v6
}

