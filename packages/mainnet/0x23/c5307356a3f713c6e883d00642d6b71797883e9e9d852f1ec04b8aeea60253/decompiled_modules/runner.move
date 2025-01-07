module 0x23c5307356a3f713c6e883d00642d6b71797883e9e9d852f1ec04b8aeea60253::runner {
    struct RUNNER has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUNNER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUNNER>(arg0, 6, b"RUNNER", b"Runner", x"5765206861766520666f756e64206f7572202452554e4e45522e0a4c65742e2049742e2052756e212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030326_8f632a5338.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUNNER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUNNER>>(v1);
    }

    // decompiled from Move bytecode v6
}

