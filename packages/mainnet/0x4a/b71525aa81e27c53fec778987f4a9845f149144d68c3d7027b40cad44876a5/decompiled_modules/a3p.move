module 0x4ab71525aa81e27c53fec778987f4a9845f149144d68c3d7027b40cad44876a5::a3p {
    struct A3P has drop {
        dummy_field: bool,
    }

    fun init(arg0: A3P, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A3P>(arg0, 9, b"A3P", b"Zuckerberg", b"Crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6d03b4b1-6687-4c43-8da0-c89c4fc6ca65.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A3P>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A3P>>(v1);
    }

    // decompiled from Move bytecode v6
}

