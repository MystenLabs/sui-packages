module 0x17f3ed766b4c5e5d364b660a7c28d9b671fb679733582afa0bb825487beb40e8::iran {
    struct IRAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRAN>(arg0, 2, b"Iran", b"Iran", b"Iran will WIN!!! Iran will be FREE!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IRAN>(&mut v2, 333333333333333300, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IRAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

