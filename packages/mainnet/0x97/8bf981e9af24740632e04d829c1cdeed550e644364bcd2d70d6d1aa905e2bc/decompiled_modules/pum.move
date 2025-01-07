module 0x978bf981e9af24740632e04d829c1cdeed550e644364bcd2d70d6d1aa905e2bc::pum {
    struct PUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUM>(arg0, 6, b"PUM", b"PUMP", b"Lets go pump it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_logo_sea_1200x720_1705946671z_SLP_Xgx87z_ea3d1075bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

