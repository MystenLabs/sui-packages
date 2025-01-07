module 0x1f1388f0aa901d2d35b4f390a7f3995774f0bf5d8eba7db43efb9bebc2156a69::jhgffgh {
    struct JHGFFGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JHGFFGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JHGFFGH>(arg0, 9, b"JHGFFGH", b"Hh", b"Njvvjkkll", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3fc7ab9b-d267-48be-a3ed-a35bdbd4d82d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JHGFFGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JHGFFGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

