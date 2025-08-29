module 0x681a44c7c5f64bddeda37effbfafef938ce73784f34ba83d7fbfa752cd56bb88::vgt {
    struct VGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VGT>(arg0, 6, b"VGT", b"Vegeta ver2", b"dont buy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1756461032070.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VGT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VGT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

