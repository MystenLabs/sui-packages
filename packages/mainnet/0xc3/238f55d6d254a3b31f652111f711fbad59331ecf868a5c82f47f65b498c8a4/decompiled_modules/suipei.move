module 0xc3238f55d6d254a3b31f652111f711fbad59331ecf868a5c82f47f65b498c8a4::suipei {
    struct SUIPEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEI>(arg0, 6, b"SUIPEI", b"PEIPEI ON SUI", x"504549504549204861732061727269766564206f6e205355490a0a436f6d65206a6f696e206f75722074656c656772616d20616e6420696e7665737420736166656c790a0a4c657473206d616b6520486973746f727920546f676574686572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/peipei_sui_d161bae115.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

