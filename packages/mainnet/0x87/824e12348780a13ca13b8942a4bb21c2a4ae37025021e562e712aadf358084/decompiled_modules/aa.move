module 0x87824e12348780a13ca13b8942a4bb21c2a4ae37025021e562e712aadf358084::aa {
    struct AA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AA>(arg0, 9, b"AA", b"Airbag ", b"Floating meme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7a093de8-80b5-4d66-94a6-56ecb73d3982.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AA>>(v1);
    }

    // decompiled from Move bytecode v6
}

