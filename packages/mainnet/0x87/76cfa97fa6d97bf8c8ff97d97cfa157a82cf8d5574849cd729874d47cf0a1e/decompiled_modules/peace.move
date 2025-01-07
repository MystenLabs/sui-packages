module 0x8776cfa97fa6d97bf8c8ff97d97cfa157a82cf8d5574849cd729874d47cf0a1e::peace {
    struct PEACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEACE>(arg0, 6, b"Peace", b"Peace ", b"Peace me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730960687851.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEACE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEACE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

