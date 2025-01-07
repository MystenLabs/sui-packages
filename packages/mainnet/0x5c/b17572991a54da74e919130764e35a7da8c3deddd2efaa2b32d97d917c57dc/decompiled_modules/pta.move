module 0x5cb17572991a54da74e919130764e35a7da8c3deddd2efaa2b32d97d917c57dc::pta {
    struct PTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTA>(arg0, 9, b"PTA", b"Puttotalk", b"Put to talk or silen to die", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/96ff17cc-82c3-4f1d-a29c-035c0dad471e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

