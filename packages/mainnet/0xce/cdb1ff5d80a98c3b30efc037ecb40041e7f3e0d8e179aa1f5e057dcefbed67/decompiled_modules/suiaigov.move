module 0xcecdb1ff5d80a98c3b30efc037ecb40041e7f3e0d8e179aa1f5e057dcefbed67::suiaigov {
    struct SUIAIGOV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAIGOV, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIAIGOV>(arg0, 6, b"SUIAIGOV", b"SuiAIGovernance by SuiAI", x"5375694149476f762c207468652041492d44414f20676f7665726e616e636520746f6b656e206f6e205375692c20656d706f776572696e6720636f6d6d756e697479206465636973696f6e732c206c656164696e6720746865206675747572652065636f73797374656d20696e74656c6c6967656e746c792ef09f9a80f09f9a80f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/3c46dd6c13354063866d7e9a37c44cea_1120115737_6461197d93.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIAIGOV>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAIGOV>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

