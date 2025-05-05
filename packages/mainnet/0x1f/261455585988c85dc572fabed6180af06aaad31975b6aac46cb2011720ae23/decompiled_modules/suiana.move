module 0x1f261455585988c85dc572fabed6180af06aaad31975b6aac46cb2011720ae23::suiana {
    struct SUIANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIANA>(arg0, 6, b"SUIANA", b"MOANA", b"...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6806a614_f294_40ba_90a5_f4f64c20465d_6887b4e27b.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

