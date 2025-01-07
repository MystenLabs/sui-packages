module 0x7c04b32e33da9aa554fbeeb14f69630300a6baf1a91aa1976a5f2bbd95bcc992::axo {
    struct AXO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXO>(arg0, 6, b"AXO", b"Axolt", b"Axo the Axolotl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951438413.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AXO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

