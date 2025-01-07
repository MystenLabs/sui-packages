module 0xd3975f6b93a93800ab0861c23d66e172bbb454d83af59364a9a0ac3372bc64c2::ade {
    struct ADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADE>(arg0, 9, b"ADE", b"Adeneyi ", b"A meme coin to recognize hardqork of sui founder ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0cf400f2-1b7e-4504-adf5-fd1e7df2706c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADE>>(v1);
    }

    // decompiled from Move bytecode v6
}

