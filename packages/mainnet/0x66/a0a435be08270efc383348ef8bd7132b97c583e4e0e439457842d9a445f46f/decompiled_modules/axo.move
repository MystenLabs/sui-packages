module 0x66a0a435be08270efc383348ef8bd7132b97c583e4e0e439457842d9a445f46f::axo {
    struct AXO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXO>(arg0, 6, b"Axo", b"$Axo", b"Axo the Axolotl | Join our journey from the HopFun trenches to the $SUI oceans", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954753820.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AXO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

