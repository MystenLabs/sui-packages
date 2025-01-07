module 0xe97e08d38a5819f1f0fcd1ddec093f5a96108671e1dc8ea82f7da97fb6279ac4::gmika {
    struct GMIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMIKA>(arg0, 6, b"GMika", b"Mika Raiba", b"Your favourite girl next door, daddy told me to buy $BITCOIN so I did.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_Rr_WP_Kov_400x400_0bcf498e32.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GMIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

