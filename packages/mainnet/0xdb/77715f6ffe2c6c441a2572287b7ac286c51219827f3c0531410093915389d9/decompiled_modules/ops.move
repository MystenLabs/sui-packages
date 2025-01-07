module 0xdb77715f6ffe2c6c441a2572287b7ac286c51219827f3c0531410093915389d9::ops {
    struct OPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPS>(arg0, 6, b"OPS", b"Call of Sui: Black Ops", b"Black $OPS is a covert task force on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/call_of_sui_f174344d91.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

