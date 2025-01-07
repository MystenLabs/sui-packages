module 0x9241bef2c0037b25cad44a51ded1eccf77d9f4d3fd6edff198a38b8d3554f5ef::nce {
    struct NCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NCE>(arg0, 9, b"NCE", b"Redbear", b"No wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9d03875-bec7-42e9-9d3f-86185ae17444.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

