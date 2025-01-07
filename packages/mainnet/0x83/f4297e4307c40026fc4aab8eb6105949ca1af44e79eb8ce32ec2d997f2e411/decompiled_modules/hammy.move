module 0x83f4297e4307c40026fc4aab8eb6105949ca1af44e79eb8ce32ec2d997f2e411::hammy {
    struct HAMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMMY>(arg0, 6, b"HAMMY", b"Hammy Sui", b"Hi, Im princess Hammy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1063_f7fa49852d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

