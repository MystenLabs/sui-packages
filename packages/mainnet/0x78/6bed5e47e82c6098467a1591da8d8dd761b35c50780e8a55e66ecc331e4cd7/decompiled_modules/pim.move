module 0x786bed5e47e82c6098467a1591da8d8dd761b35c50780e8a55e66ecc331e4cd7::pim {
    struct PIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIM>(arg0, 6, b"PIM", b"Pimling on Sui", b"Pim is the eternally optimistic and cheerful character from Smiling Friends Inc.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_50_65fd300c64.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

