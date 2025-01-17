module 0x1b626260316d74c5f30d52ab36f7c2052cda328a43357f7495a63ac531b538ad::suipo {
    struct SUIPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPO>(arg0, 6, b"SUIPO", b"SuidPool", b"The great DeadPool of SUI, if you are not investing you can suck my balls..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3106_832c730cb2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

