module 0x925e0ca1a22efaea92db7dc092a6f165e5e3c0553f9906a47b0d381f69ecc05f::duak {
    struct DUAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUAK>(arg0, 6, b"DUAK", b"DUAK on SUI", b"We're here to make waves, blending smiles with ease as we chart our course.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732283757519.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUAK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUAK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

