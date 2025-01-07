module 0x4dc7d676ee13dbf564b6eb89d08d3bd2279044434fb132b9e0c4af54b3f9ad1c::cristiano {
    struct CRISTIANO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRISTIANO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRISTIANO>(arg0, 9, b"CRISTIANO", b"CR7", b"SUI SUI RONALDO, MEME RONALDO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7798ffa8-b997-49cc-82fc-13c50c2a37bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRISTIANO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRISTIANO>>(v1);
    }

    // decompiled from Move bytecode v6
}

