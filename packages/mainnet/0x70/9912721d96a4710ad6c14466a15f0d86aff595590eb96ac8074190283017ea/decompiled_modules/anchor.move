module 0x709912721d96a4710ad6c14466a15f0d86aff595590eb96ac8074190283017ea::anchor {
    struct ANCHOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANCHOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANCHOR>(arg0, 6, b"ANCHOR", b"Sui Anchor", x"53746561647920616e6420756e6d6f7661626c652c2024414e43484f52206b6565707320796f757220696e766573746d656e74732067726f756e64656420696e2074686520537569204e6574776f726b2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_27_99c1282268_97d20b0794.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANCHOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANCHOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

