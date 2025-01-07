module 0xe771a2b24cb4c917bfac7b42bf184fde6c545122e4f5f01b440afd6554c9c572::winu {
    struct WINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINU>(arg0, 6, b"WINU", b"Wrapped Inu", b"if i reach 1B,i won't feel cold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_1d729435cc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

