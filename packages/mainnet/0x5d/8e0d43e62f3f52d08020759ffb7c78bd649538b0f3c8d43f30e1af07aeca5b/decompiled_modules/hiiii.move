module 0x5d8e0d43e62f3f52d08020759ffb7c78bd649538b0f3c8d43f30e1af07aeca5b::hiiii {
    struct HIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIIII>(arg0, 9, b"HIIII", b"Hi", b"Hii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ebcbd069-d378-47bb-9159-175c073df277.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

