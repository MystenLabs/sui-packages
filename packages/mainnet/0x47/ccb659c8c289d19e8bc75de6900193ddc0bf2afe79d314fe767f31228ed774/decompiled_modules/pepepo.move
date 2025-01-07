module 0x47ccb659c8c289d19e8bc75de6900193ddc0bf2afe79d314fe767f31228ed774::pepepo {
    struct PEPEPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEPO>(arg0, 6, b"PEPEPO", b"PEPE PO ON SUI", b"Miss PEPE ? This is last chance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_1_2_7c7ca61c63.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

