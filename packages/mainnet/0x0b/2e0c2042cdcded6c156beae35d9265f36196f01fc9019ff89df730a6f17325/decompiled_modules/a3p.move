module 0xb2e0c2042cdcded6c156beae35d9265f36196f01fc9019ff89df730a6f17325::a3p {
    struct A3P has drop {
        dummy_field: bool,
    }

    fun init(arg0: A3P, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A3P>(arg0, 9, b"A3P", b"Zuckerberg", b"Crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d7404e6-14c6-4d92-ba67-acecbb53e76f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A3P>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A3P>>(v1);
    }

    // decompiled from Move bytecode v6
}

