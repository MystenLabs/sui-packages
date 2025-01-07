module 0x6f858249bc81822a58c5507b1dfd8160b00a2a5f7b05c09d5ab3202f09ff1365::cs {
    struct CS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CS>(arg0, 6, b"CS", b"Credit Suisse", b"The real bank of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003602_26cd114f8a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CS>>(v1);
    }

    // decompiled from Move bytecode v6
}

