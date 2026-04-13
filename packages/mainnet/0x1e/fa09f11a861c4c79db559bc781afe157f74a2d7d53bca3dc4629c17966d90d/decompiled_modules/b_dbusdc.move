module 0x1efa09f11a861c4c79db559bc781afe157f74a2d7d53bca3dc4629c17966d90d::b_dbusdc {
    struct B_DBUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_DBUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_DBUSDC>(arg0, 9, b"bDBUSDC", b"bToken DBUSDC", b"TURBOS bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.turbos.finance/icon/turbosbtoken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_DBUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_DBUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

