module 0xa5e52201a98a2e9799596e6a7ba4fc0b91f7f5768eacfcceba65dfc343de9d85::savecetus {
    struct SAVECETUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAVECETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAVECETUS>(arg0, 6, b"SAVECETUS", b"SaveCetus", b"Save Cetus! Help rebuild the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747920650726.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAVECETUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAVECETUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

