module 0x309fa3a9ea0d40aa6c1fcf763aa61d56c1db31847ddcbb6bff7932fe6db7403b::ruff {
    struct RUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUFF>(arg0, 6, b"RUFF", b"RUFF SUI", b"$RUFF CEO OF MONKEY BUSINESS!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_27_00_42_35_668f508ed8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

