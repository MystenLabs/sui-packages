module 0xb2a668513d4068a6ab985042d90bd01ea38faf4a0cfce2c6530a66e5e4d6356d::sulo {
    struct SULO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SULO>(arg0, 9, b"SULO", b"Sunlong", b"The sibling meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cb7984e7-187d-4447-8a5c-26c3a14c8fd2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SULO>>(v1);
    }

    // decompiled from Move bytecode v6
}

