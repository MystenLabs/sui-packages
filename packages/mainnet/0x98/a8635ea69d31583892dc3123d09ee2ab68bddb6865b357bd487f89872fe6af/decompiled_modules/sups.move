module 0x98a8635ea69d31583892dc3123d09ee2ab68bddb6865b357bd487f89872fe6af::sups {
    struct SUPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPS>(arg0, 6, b"SUPS", b"supersui", b"Tell your friends about SuperSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Super_Sui_968fb75732.bin")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

