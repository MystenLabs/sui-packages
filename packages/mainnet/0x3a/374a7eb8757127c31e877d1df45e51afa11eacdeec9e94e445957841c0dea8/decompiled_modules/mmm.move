module 0x3a374a7eb8757127c31e877d1df45e51afa11eacdeec9e94e445957841c0dea8::mmm {
    struct MMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMM>(arg0, 9, b"MMM", b"meomeo", b"MMMMA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9b3d6d0c-5d9f-428b-8067-19f3ce3b1d43.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

