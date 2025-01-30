module 0x34cf1f0b754506819f770ee6b1ff57f8d634eb67ca1bff859d5f09f90a859665::HEN {
    struct HEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEN>(arg0, 9, b"HEN", b"HEN", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HEN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<HEN>>(0x2::coin::mint<HEN>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

