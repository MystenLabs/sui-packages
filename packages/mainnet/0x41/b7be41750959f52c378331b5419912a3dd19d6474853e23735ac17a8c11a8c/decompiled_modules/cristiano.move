module 0x41b7be41750959f52c378331b5419912a3dd19d6474853e23735ac17a8c11a8c::cristiano {
    struct CRISTIANO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRISTIANO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRISTIANO>(arg0, 9, b"CRISTIANO", b"CR7", b"SUI SUI RONALDO, MEME RONALDO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/51e32dee-5b7f-405e-af32-9ef4d78f011b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRISTIANO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRISTIANO>>(v1);
    }

    // decompiled from Move bytecode v6
}

