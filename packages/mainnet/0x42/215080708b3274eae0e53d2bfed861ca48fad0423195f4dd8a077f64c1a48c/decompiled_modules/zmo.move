module 0x42215080708b3274eae0e53d2bfed861ca48fad0423195f4dd8a077f64c1a48c::zmo {
    struct ZMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZMO>(arg0, 9, b"ZMO", b"Zeemo ", b"Zeemo is the father of 16 son who look after their sons in difficult situation and didn't lost his hope and now he is a successful business man.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b3613537-bd77-44e8-a69c-95e321738db1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

