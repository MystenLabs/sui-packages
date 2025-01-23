module 0xf2031fd162f8fb49b58e86bec074a885e0ebb60f8c32e3fef23f007d394012d5::frogg {
    struct FROGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGG>(arg0, 9, b"FROGG", b"FROGGY", x"65617420736f6d652062616e616e6120627275680a0a46524f47", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3b11ab90a2e660d2f6a813223c3d8d35blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROGG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

