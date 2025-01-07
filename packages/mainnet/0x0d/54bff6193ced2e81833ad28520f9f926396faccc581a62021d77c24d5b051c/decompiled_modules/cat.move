module 0xd54bff6193ced2e81833ad28520f9f926396faccc581a62021d77c24d5b051c::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 6, b"CAT", b"Cat", b"Say hello to Cat and lets follow our journey to make new historycal and make SUI great again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730994265029.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

