module 0x324c6951bf7dad34c92afdce1b9d0128abe3caabafb7155d98143fabd704ca80::acy {
    struct ACY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACY>(arg0, 6, b"ACY", b"Anchovy", b"MEEP MEEP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956166832.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

