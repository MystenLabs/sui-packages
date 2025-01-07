module 0xbcb328da7c9f24c42aafe526366cb953778a46281a04a6133c023cd7a61fc15::kage {
    struct KAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAGE>(arg0, 6, b"KAGE", b"Grifters", b"Expose the grifters KAGE society", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TX_4_a_Cbx_400x400_7806311d51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

