module 0xae47c544679ebf0eb0f43a4c76539263dd6820ae6609f1dcbe02941148f17b7c::b0a1 {
    struct B0A1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B0A1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B0A1>(arg0, 6, b"B0A1", b"B0A1 ai revolution", b"AI Revolution", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_18_21_42_53_a5e880157d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B0A1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B0A1>>(v1);
    }

    // decompiled from Move bytecode v6
}

