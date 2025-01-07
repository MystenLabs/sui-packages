module 0x4a0ceadcbaabbfc840f86b4474d54cf058626e4b54291329c05f1dea72f546f4::bic {
    struct BIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIC>(arg0, 6, b"BIC", b"SUIBIC", b"BIC JUST A MEME ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_DYQP_1h_ZQ_b0c47e3f13.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

