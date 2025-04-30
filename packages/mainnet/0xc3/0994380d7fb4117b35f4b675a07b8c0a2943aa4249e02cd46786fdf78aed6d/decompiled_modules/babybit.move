module 0xc30994380d7fb4117b35f4b675a07b8c0a2943aa4249e02cd46786fdf78aed6d::babybit {
    struct BABYBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYBIT>(arg0, 6, b"Babybit", b"BabyBitcoin", b"Babybitcoin on SUi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_1_2b05608414.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

