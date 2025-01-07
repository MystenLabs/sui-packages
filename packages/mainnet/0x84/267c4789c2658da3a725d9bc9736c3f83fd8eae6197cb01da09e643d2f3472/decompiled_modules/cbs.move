module 0x84267c4789c2658da3a725d9bc9736c3f83fd8eae6197cb01da09e643d2f3472::cbs {
    struct CBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBS>(arg0, 6, b"CBS", b"Care Bears on SUI", b"Buy Care Bears on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7dz_Bdc_An_400x400_4ab964b7b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

