module 0x891402894913db7d35d83c3ee798c1c74525cb02ddc941fb7dfda46de9f66c58::suiperdm {
    struct SUIPERDM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPERDM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPERDM>(arg0, 6, b"SUIPERDM", b"Suiper dogemusk", x"53754970657220446f67654d75736b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/462f2fb018d4c3bb510625c2ee8e3b32_df4276d2f6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPERDM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPERDM>>(v1);
    }

    // decompiled from Move bytecode v6
}

