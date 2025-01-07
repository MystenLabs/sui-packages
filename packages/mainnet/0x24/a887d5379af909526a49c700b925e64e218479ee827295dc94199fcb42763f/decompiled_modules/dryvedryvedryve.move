module 0x24a887d5379af909526a49c700b925e64e218479ee827295dc94199fcb42763f::dryvedryvedryve {
    struct DRYVEDRYVEDRYVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRYVEDRYVEDRYVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRYVEDRYVEDRYVE>(arg0, 9, b"Dryvedryvedryve", b"Testdryve9", b"None", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DRYVEDRYVEDRYVE>(&mut v2, 300000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRYVEDRYVEDRYVE>>(v2, @0x838768f6f87d4fbc2e13657c4574ec01be6283c7a63b40bec3e40d521d980c97);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRYVEDRYVEDRYVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

