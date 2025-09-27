module 0x443ed1e8907bc705d7a80da765e751407c65ffc1aac752c74472abfc7a815885::mbu {
    struct MBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBU>(arg0, 6, b"MBU", b"MBU2025", x"4d6172c3ad612042657272c3ad6f2c20556e7469746c65642c2032303235", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arttoo.app/artworks/coin/loj.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MBU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

