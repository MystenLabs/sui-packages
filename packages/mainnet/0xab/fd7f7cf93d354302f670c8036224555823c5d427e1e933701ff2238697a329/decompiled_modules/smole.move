module 0xabfd7f7cf93d354302f670c8036224555823c5d427e1e933701ff2238697a329::smole {
    struct SMOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOLE>(arg0, 6, b"SMOLE", b"Sui Smole", x"24736d6f6c65202d20736d6f6c65636f696e0a0a6120736d6f6c206d6f6c6520616e642074686520736d6f6c6c65737420736d6f6c65636f696e20696e2074686520736d6f6c6e65740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/snow_c23de33591.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

