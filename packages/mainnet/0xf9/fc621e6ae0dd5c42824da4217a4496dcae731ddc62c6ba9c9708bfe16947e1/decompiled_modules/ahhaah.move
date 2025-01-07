module 0xf9fc621e6ae0dd5c42824da4217a4496dcae731ddc62c6ba9c9708bfe16947e1::ahhaah {
    struct AHHAAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHHAAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHHAAH>(arg0, 9, b"AHHAAH", b"Kkk", x"48c3a26868616861", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/130d4bf6-0200-431d-996a-e463197302e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHHAAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AHHAAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

