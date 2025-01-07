module 0x6ec217b1d9ea50c2a657219213ca8b54148b919a33ce036853b57c83555f4607::minideng {
    struct MINIDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINIDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINIDENG>(arg0, 6, b"MINIDENG", b"MiniDeng", b"Official MINIDENG on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/44444_1d0c02b5e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINIDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINIDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

