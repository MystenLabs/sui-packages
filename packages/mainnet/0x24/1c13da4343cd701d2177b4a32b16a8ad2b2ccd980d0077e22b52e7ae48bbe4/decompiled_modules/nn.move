module 0x241c13da4343cd701d2177b4a32b16a8ad2b2ccd980d0077e22b52e7ae48bbe4::nn {
    struct NN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NN>(arg0, 9, b"NN", b"nano", b"NN33", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8f7bec8-d0db-42d6-a8a1-fc37e1d7e707.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NN>>(v1);
    }

    // decompiled from Move bytecode v6
}

