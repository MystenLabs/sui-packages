module 0x2fb595a7bd9c77bec9d1f6df9bef830a54f43cefdd0746409300c807a1d930b3::dmaga {
    struct DMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMAGA>(arg0, 6, b"DMAGA", b"DARK MAGA", x"4441524b204d41474120415353454d424c4521200a746865206e65772047656e65726174696f6e206f66204d616b6520416d657269636120477265617420416761696e2066726f6d2076657279204f776e20456c6f6e204d75736b2054776565742e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2179_35752cfe9a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

