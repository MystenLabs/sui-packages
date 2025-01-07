module 0x264407d1f4e9b06b194282d096dd96444aeacb75870b88cfa8562a4fcdd7d7fb::sloth {
    struct SLOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOTH>(arg0, 9, b"SLOTH", b"Slothana", b"Slothana coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2971bbc1-92b1-49be-8a7b-bd66f3996cf2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLOTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

