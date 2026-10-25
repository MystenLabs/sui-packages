module 0x7f0bc21fc9744c07097f9ecfc8fc88938d32444a747695f337f146956e15f36b::hah {
    struct HAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<HAH>(arg0, 9, 0x1::string::utf8(b"HAH"), 0x1::string::utf8(b"hitl"), 0x1::string::utf8(b"hitl (HAH)"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<HAH>>(0x2::coin_registry::finalize<HAH>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

