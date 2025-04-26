module 0xf519baf2c53cf95ab1649d510ce86dc6cebc637fd387c3e74b09432c73152314::slw {
    struct SLW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLW>(arg0, 6, b"SLW", b"Slush Wallet", b"slush wallet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fewcha_aa7b363a39.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLW>>(v1);
    }

    // decompiled from Move bytecode v6
}

