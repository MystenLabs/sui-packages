module 0x34faa68cd9c3d6bd0597b3a81dc1fadc68e70233a56b0fbfd319f6ac57127ed4::dgb {
    struct DGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGB>(arg0, 9, b"DGB", b"DragonBall", b"An ancient Chinese dragon a symbol of wealth and gold.. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/04c9914c-826a-4e1e-8189-8a9cba3dfeb1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGB>>(v1);
    }

    // decompiled from Move bytecode v6
}

