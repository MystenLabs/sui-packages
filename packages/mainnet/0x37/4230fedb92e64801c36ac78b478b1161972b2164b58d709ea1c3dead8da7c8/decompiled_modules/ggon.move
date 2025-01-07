module 0x374230fedb92e64801c36ac78b478b1161972b2164b58d709ea1c3dead8da7c8::ggon {
    struct GGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGON>(arg0, 9, b"GGON", b"Gaga on", b"Meme for everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/163d8adc-54a0-4c1f-b5c5-cd2d29bf6a4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

