module 0x6d7aaa981860839d003a5bf7f4e4af20ba056fd4cf8444902b420f4375e536b3::savecetus {
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

