module 0x7203ea76b699d2765371d5453dceca93d099de6d7f8b7a94d5d462dd6b351c41::myphuc {
    struct MYPHUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYPHUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYPHUC>(arg0, 9, b"MYPHUC", b"MP", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed8a1280-881b-4316-85ac-8a437c19d4c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYPHUC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYPHUC>>(v1);
    }

    // decompiled from Move bytecode v6
}

