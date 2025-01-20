module 0x5566dabc7671550dea871d8c5dcc8fd4f1534877fc4725e559af69a37db34bb6::natl {
    struct NATL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NATL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NATL>(arg0, 6, b"NATL", b"Natalius Agent AI", x"54686520666972737420234465464149204167656e74206f6e205375690a416c6c2d696e2d6f6e65207468726f756768206e61747572616c206c616e6775616765", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250121_000434_844_75136e2add.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NATL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NATL>>(v1);
    }

    // decompiled from Move bytecode v6
}

