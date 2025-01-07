module 0x59a48586fdfa207fe7a39a6503a36416b4dfb294254376a80e3e0c5ad5bd9680::mud {
    struct MUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUD>(arg0, 6, b"MUD", b"MudkipOnSui", b"Cutest Mudkip is launch on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730980397029.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

