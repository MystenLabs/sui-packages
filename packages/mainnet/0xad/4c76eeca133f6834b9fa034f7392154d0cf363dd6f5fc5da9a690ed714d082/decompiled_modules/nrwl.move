module 0xad4c76eeca133f6834b9fa034f7392154d0cf363dd6f5fc5da9a690ed714d082::nrwl {
    struct NRWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NRWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NRWL>(arg0, 6, b"NRWL", b"Narwhaleicious ($NRWL)", b"The coolest Narwhale is dive into Sui Blockchain to build a strong community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_c834e18497.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NRWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NRWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

