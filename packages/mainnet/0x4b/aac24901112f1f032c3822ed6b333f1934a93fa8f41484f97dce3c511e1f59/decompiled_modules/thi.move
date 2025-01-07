module 0x4baac24901112f1f032c3822ed6b333f1934a93fa8f41484f97dce3c511e1f59::thi {
    struct THI has drop {
        dummy_field: bool,
    }

    fun init(arg0: THI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THI>(arg0, 9, b"THI", b"Outrage ", x"49e280996d206a75737420676f696e67207468726f7567682074686520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c818d235-622f-4d17-873b-0bd662ef023e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THI>>(v1);
    }

    // decompiled from Move bytecode v6
}

