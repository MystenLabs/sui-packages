module 0xc10883a00341ac2791f8172d8a30f2b4519dbba136bf00cc7345c707bf202874::nobh {
    struct NOBH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOBH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOBH>(arg0, 9, b"NOBH", b"Nooboy", b"Creat meme for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18399a08-527a-4d83-a6d5-e51734bac502.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOBH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOBH>>(v1);
    }

    // decompiled from Move bytecode v6
}

