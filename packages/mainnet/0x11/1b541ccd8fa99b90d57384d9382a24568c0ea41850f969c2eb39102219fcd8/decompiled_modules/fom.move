module 0x111b541ccd8fa99b90d57384d9382a24568c0ea41850f969c2eb39102219fcd8::fom {
    struct FOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOM>(arg0, 6, b"FOM", b"Freedom Of Money", b"Get your Freedom Of Money on Sui. Powered by the holders. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1778062823031.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

