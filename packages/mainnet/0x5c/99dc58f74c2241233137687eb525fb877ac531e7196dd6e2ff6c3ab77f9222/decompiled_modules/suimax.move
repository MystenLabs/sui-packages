module 0x5c99dc58f74c2241233137687eb525fb877ac531e7196dd6e2ff6c3ab77f9222::suimax {
    struct SUIMAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAX>(arg0, 6, b"SuiMAX", b"SuiMAXiMUM", x"5375694d4158694d554d206265796f6e6420746865206675747572650a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736708590686.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMAX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

