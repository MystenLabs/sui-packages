module 0x868047c69f8bb631c0a58e854a7a3acac5a9298efd5d5436b22b87067a3b63bd::pta {
    struct PTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTA>(arg0, 9, b"PTA", b"Puttotalk", b"Put to talk or silen to die", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/430afc89-eae8-4686-a417-9c2c6f47ae25.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

