module 0xd7d0838617698ec7d55ce79cf30c296ffdfabd6414072df9e4906c9ebdc8f898::maggi_45 {
    struct MAGGI_45 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGGI_45, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGGI_45>(arg0, 9, b"MAGGI_45", b"Maggi", b"For fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/88174c35-04f0-4d1b-90f9-c2b966f20978.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGGI_45>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGGI_45>>(v1);
    }

    // decompiled from Move bytecode v6
}

