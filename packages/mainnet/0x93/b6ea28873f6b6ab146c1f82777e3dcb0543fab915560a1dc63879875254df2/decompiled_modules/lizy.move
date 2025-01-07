module 0x93b6ea28873f6b6ab146c1f82777e3dcb0543fab915560a1dc63879875254df2::lizy {
    struct LIZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIZY>(arg0, 6, b"LIZY", b"Lizy On Sui", b"Lizy is the sweetest cat on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_30_18_08_29_71a53a2cda.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

