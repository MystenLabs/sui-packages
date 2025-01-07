module 0x15785fc0e09deadb3511c22f84db811324e5a052cd8977b23e2f7f0eceee1df0::djsa {
    struct DJSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJSA>(arg0, 6, b"DJsa", b"dfas", b"cxf hdafds", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_20_23_23_03_df762c2c2f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DJSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

