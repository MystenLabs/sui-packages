module 0xd8e3fd2fc55f267c55ef60bef6d4458d2d765f5cc32cbf095d1a78ef92a15bd6::fudd {
    struct FUDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDD>(arg0, 6, b"Fudd", b"Fuddies", b"FUD around and find out", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_O_Rzt_FXI_400x400_da3c24f130.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

