module 0x32433b2bac382aa9b0434283f6deaec3f9a751f99f549dacf75007e671228e::hUSDSUI {
    struct HUSDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUSDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUSDSUI>(arg0, 6, b"hUSDSUI", b"hUSDSUI Coin", b"hUSDSUI Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUSDSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUSDSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

