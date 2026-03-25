module 0x189dff6dd5632b982796fef26ee9f1c4ba8a4627236fbfbc5fef56378b85b2e::get_rich {
    struct GET_RICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GET_RICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GET_RICH>(arg0, 0x9e20798d97c110f6b36b7b3d8543aa9246322ef2fd8d83ad79ef3325d473bc2f::constants::lp_decimals(), b"GET_RICH", b"RICH", b"we getting rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GET_RICH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GET_RICH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

