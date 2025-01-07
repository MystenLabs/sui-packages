module 0x790cae32561800efa0f2ef5070ffd8d42bf209cf28a117c965bd391e4a127b2::pan {
    struct PAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAN>(arg0, 9, b"PAN", b"Panda Wewe", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e745fd7c-80c2-44f0-adee-6e1daf1746d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

