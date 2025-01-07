module 0xf5be2953ddcfc24b1aa08e0e52f263d5404409466eff40be3a707ae513872daf::bscc {
    struct BSCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSCC>(arg0, 6, b"BSCC", b"BSCCToken", b"It is test token description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://testtoken")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSCC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSCC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

