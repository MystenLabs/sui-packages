module 0x3eab06897f6c7786c1873b13e1eccdae9d719a89afef4de1b839ad0267766c65::brusui {
    struct BRUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUSUI>(arg0, 6, b"BRUSUI", b"Bruce Sui", x"42652077617465722c206d7920667269656e642e202d204272756365205375690a456e7465722074686520776174657220636861696e2e2057617474746161686821", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1033_40f568163d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

