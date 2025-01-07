module 0x24ebd7197039b04e5d12e0e63b14c47e376c52f84da57f18e23885c59d3eed29::shrimp {
    struct SHRIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRIMP>(arg0, 6, b"SHRIMP", b"Sui Shrimp", b"Small but mighty, Sui Shrimp is ready to swim through the Sui seas. Dont let the size fool you. This shrimps got big plans on the blockchain. Join the shrimp squad.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_61_e4be5178cc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRIMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

