module 0x5658ca4e04a69a129a17c574c6d47dc88680c448a33b5875b1cf8c8c232ea7fe::buck {
    struct BUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCK>(arg0, 6, b"Buck", b"Banana Duck", b"The Banana Duck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_Ou_VO_8_WJ_400x400_cbdc8c49b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

