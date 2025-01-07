module 0x245d4ce87c0f0014bf02e08dee85ae8ab9b3ea98649d1b32d43bd998a7855bea::butc {
    struct BUTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUTC>(arg0, 6, b"BUTC", b"BUTTCOIN", b"Join Us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/18a302aa79194bdf0111f0a21846833f7e6a031d5313b77c455d3a771d905e43i0_1242ed56c3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

