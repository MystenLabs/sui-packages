module 0x11dc049d1ed24f3ec4439e1ffdac7acd1b8404de791fcdb86d3e8973f10e5d5a::ade {
    struct ADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADE>(arg0, 9, b"ADE", b"ADEIZA", b"ADEIZA TO THE MOON!!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f70f609b-2693-48fa-9083-126a8e3b3847.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADE>>(v1);
    }

    // decompiled from Move bytecode v6
}

