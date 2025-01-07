module 0x9ccf8f6aab9a63672f93c034129f350320f9fbee45506d7c178c83464a13cb5a::bib {
    struct BIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIB>(arg0, 6, b"BIB", b"Bibi", b"Bibi the Sandy Seal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bebe_ca50cd0819.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

