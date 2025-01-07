module 0xe3906b53db029578f2d320ca1912785178ca647b94f20ce0f86935d95b5efd9a::anakin {
    struct ANAKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANAKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANAKIN>(arg0, 9, b"ANAKIN", b"Anakin pad", b"For the bettrr right?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4d102d4d-3829-4bc1-bff6-b77a5a0528e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANAKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANAKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

