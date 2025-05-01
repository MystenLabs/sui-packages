module 0x5c1cb2a1d301563b4ee8e2f3dda6a7eb7c6b60bf108c0dc53d6e21806c9a844a::aaa_sui {
    struct AAA_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAA_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAA_SUI>(arg0, 9, b"aaaSUI", b"AAA Staked SUI", b"AAA Staked Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/f2a9778d-3c2e-405e-b88e-41ebde018b1e/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAA_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAA_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

