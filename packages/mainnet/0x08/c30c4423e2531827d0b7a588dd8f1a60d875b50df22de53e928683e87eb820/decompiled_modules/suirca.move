module 0x8c30c4423e2531827d0b7a588dd8f1a60d875b50df22de53e928683e87eb820::suirca {
    struct SUIRCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRCA>(arg0, 6, b"SUIRCA", b"Sui Orca", b"Meet with Sui Orca ($SUIRCA), The apex predator of the Sui waters.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_91_0d7c605117.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

