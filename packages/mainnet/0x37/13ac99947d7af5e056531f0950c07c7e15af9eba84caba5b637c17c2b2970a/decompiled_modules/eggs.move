module 0x3713ac99947d7af5e056531f0950c07c7e15af9eba84caba5b637c17c2b2970a::eggs {
    struct EGGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGS>(arg0, 6, b"EGGS", b"EGGS", x"496e2074686520766f6c6174696c6520776f726c64206f662063727970746f2c204547475320726570726573656e7420756e74617070656420706f74656e7469616c20e2809420736d616c6c2c2066726167696c65e280a6206275742063617061626c65206f6620626c6f73736f6d696e6720696e746f20736f6d657468696e6720656e6f726d6f75732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EGGS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

