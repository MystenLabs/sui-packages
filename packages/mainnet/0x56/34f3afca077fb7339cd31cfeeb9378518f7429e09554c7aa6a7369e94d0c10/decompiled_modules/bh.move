module 0x5634f3afca077fb7339cd31cfeeb9378518f7429e09554c7aa6a7369e94d0c10::bh {
    struct BH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BH>(arg0, 9, b"BH", b"Hh", b"Gh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c66a813-be56-40da-a76e-1185caccf4f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BH>>(v1);
    }

    // decompiled from Move bytecode v6
}

