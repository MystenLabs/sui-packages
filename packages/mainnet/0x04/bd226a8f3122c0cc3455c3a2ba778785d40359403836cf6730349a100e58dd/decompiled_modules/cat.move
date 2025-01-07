module 0x4bd226a8f3122c0cc3455c3a2ba778785d40359403836cf6730349a100e58dd::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 6, b"CAT", b"CAT ", b"just a cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730967771391.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

