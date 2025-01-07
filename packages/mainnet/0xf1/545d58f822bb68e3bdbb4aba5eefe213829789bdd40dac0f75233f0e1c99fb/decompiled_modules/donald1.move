module 0xf1545d58f822bb68e3bdbb4aba5eefe213829789bdd40dac0f75233f0e1c99fb::donald1 {
    struct DONALD1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONALD1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONALD1>(arg0, 6, b"DONALD1", b"DONALD 1ST", b"Next world's emperor looking for his subjects", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Donald_1_8f1b632c31.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONALD1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONALD1>>(v1);
    }

    // decompiled from Move bytecode v6
}

