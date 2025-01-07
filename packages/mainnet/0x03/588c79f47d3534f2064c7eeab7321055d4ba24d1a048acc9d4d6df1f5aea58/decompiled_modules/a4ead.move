module 0x3588c79f47d3534f2064c7eeab7321055d4ba24d1a048acc9d4d6df1f5aea58::a4ead {
    struct A4EAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: A4EAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A4EAD>(arg0, 9, b"A4EAD", b"AHEAD", b"AHEAD case", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/353e6192-8312-4e4a-a3ea-ea8f6cce08a3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A4EAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A4EAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

