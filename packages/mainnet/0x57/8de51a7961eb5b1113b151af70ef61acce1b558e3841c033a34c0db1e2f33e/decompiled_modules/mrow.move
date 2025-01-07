module 0x578de51a7961eb5b1113b151af70ef61acce1b558e3841c033a34c0db1e2f33e::mrow {
    struct MROW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MROW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MROW>(arg0, 6, b"MROW", b"SUIMROW", b"MROW MROW MROW MROW MROW MROW MROW MROW MROW MROW MROW MROW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_22_52_59_0f7e445dc8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MROW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MROW>>(v1);
    }

    // decompiled from Move bytecode v6
}

