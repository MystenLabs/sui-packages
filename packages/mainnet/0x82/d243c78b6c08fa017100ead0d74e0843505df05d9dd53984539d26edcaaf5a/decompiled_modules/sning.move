module 0x82d243c78b6c08fa017100ead0d74e0843505df05d9dd53984539d26edcaaf5a::sning {
    struct SNING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNING>(arg0, 6, b"SNING", b"Suinning", x"57652061726520676f6e6e61207375696e20736f206d7563682c20796f75206d6179206576656e20676574207469726564206f66207375696e6e696e67210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUINNING_909f4d3a3e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNING>>(v1);
    }

    // decompiled from Move bytecode v6
}

