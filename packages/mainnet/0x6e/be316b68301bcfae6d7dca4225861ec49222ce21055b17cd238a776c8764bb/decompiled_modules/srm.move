module 0x6ebe316b68301bcfae6d7dca4225861ec49222ce21055b17cd238a776c8764bb::srm {
    struct SRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRM>(arg0, 6, b"SRM", b"Shimmy", b"Shimmer on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730998877992.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SRM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

