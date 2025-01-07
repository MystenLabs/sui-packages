module 0xcd930e8e61d000db2a2d46098e1f54e8e94eadc86eb2d9907b1dba26006c7d3b::art {
    struct ART has drop {
        dummy_field: bool,
    }

    fun init(arg0: ART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ART>(arg0, 9, b"ART", b"Latte ", b"Coffee ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3a03ac6b-944f-45d2-8a18-1f13bf1aebe1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ART>>(v1);
    }

    // decompiled from Move bytecode v6
}

