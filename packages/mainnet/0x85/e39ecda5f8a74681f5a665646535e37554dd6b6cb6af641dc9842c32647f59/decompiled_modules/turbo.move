module 0x85e39ecda5f8a74681f5a665646535e37554dd6b6cb6af641dc9842c32647f59::turbo {
    struct TURBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBO>(arg0, 6, b"TURBO", b"Turbo", b"THE OFC MASKOT OF TURBOS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950174412.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

