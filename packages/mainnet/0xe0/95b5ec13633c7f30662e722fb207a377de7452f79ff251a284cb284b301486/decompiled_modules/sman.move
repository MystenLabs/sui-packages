module 0xe095b5ec13633c7f30662e722fb207a377de7452f79ff251a284cb284b301486::sman {
    struct SMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMAN>(arg0, 9, b"SMAN", b"Stickman", b"Stickman has fall in love with sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e30d4e64-1f5e-4263-b374-a7e08b1ec438.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

