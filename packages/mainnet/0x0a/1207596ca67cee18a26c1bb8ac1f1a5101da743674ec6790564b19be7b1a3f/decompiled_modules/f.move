module 0xa1207596ca67cee18a26c1bb8ac1f1a5101da743674ec6790564b19be7b1a3f::f {
    struct F has drop {
        dummy_field: bool,
    }

    fun init(arg0: F, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<F>(arg0, 0x83fa035d3d43c4da8af5c961cb604cd564e13b9622c306eb5127ae8fbf761ca7::constants::lp_decimals(), b"F", b"Af", b"d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<F>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<F>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

