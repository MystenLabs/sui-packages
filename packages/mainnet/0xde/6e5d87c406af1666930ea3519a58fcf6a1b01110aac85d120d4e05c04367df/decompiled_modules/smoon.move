module 0xde6e5d87c406af1666930ea3519a58fcf6a1b01110aac85d120d4e05c04367df::smoon {
    struct SMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOON>(arg0, 6, b"SMOON", b"Suilor Moon", x"47657420726561647920746f20676f20746f20746865206d6f6f6e2120f09f9a80f09f8c950a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734645313560.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMOON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

