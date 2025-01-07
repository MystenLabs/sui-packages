module 0x6d4d404d0e8c912402317e280a234a079e70848ec2917e7e415ecb6ba4669918::pwne {
    struct PWNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWNE>(arg0, 9, b"PWNE", b"hdjd", b"dhkdn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/09428b18-94ae-46e4-831a-0c27f3d507a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PWNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

