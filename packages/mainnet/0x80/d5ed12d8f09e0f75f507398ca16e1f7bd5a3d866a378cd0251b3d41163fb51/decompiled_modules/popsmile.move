module 0x80d5ed12d8f09e0f75f507398ca16e1f7bd5a3d866a378cd0251b3d41163fb51::popsmile {
    struct POPSMILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPSMILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPSMILE>(arg0, 6, b"POPSMILE", b"POPSMILE on SUI", b"Buy Now Smile Later", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R_Sq_Cbdzx_400x400_08834f7033.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPSMILE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPSMILE>>(v1);
    }

    // decompiled from Move bytecode v6
}

