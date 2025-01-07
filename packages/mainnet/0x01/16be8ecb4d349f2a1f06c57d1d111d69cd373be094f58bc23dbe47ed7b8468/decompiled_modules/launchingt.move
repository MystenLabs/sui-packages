module 0x116be8ecb4d349f2a1f06c57d1d111d69cd373be094f58bc23dbe47ed7b8468::launchingt {
    struct LAUNCHINGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNCHINGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAUNCHINGT>(arg0, 6, b"Launchingt", b"Launchington", b"Launchington2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732070564049.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAUNCHINGT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAUNCHINGT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

