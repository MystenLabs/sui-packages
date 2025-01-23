module 0xd8c814b53e941ab398f56ac989e2f174e52c01a9940f646c691922a2798cfe74::dms {
    struct DMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMS>(arg0, 9, b"DMS", b"DAO MING SI", b"F4 LEADER! BE READY!!! RED CARD!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/af854800-d985-11ef-80e8-811f7f414973")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMS>>(v1);
        0x2::coin::mint_and_transfer<DMS>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

