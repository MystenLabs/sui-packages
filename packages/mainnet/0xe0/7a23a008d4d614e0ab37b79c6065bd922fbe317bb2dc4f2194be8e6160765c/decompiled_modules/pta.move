module 0xe07a23a008d4d614e0ab37b79c6065bd922fbe317bb2dc4f2194be8e6160765c::pta {
    struct PTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTA>(arg0, 9, b"PTA", b"Puttotalk", b"Put to talk or silen to die", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d83ef493-596e-4239-83e4-7b4aa9a3b210.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

