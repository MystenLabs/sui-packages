module 0x767b1a2dd661886f2d1582d3679d4ca79ed202fe29ae392bce5a5330bff70bfb::ep {
    struct EP has drop {
        dummy_field: bool,
    }

    fun init(arg0: EP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EP>(arg0, 9, b"EP", b"Emprire", b"Empire", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/56b7b1b8-22c3-4907-99a4-01cf5b2a1d4f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EP>>(v1);
    }

    // decompiled from Move bytecode v6
}

