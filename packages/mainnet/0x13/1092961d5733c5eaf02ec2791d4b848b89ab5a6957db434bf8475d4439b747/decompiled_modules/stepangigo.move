module 0x131092961d5733c5eaf02ec2791d4b848b89ab5a6957db434bf8475d4439b747::stepangigo {
    struct STEPANGIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEPANGIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEPANGIGO>(arg0, 9, b"STEPANGIGO", b"Gigo", b"The first real CryptoStepanGigo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/81be7fca-bd55-49d6-97a7-b698fbb5e470.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEPANGIGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STEPANGIGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

