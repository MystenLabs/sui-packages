module 0xa1552c18020007c063ed4171fc88a5f625c20b63370327b3df8879ceade800ad::pochita {
    struct POCHITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POCHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POCHITA>(arg0, 6, b"POCHITA", b"Pochita On Sui", b"ex-breeder ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pochita_811acbfda0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POCHITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POCHITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

