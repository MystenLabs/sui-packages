module 0x3a6f70831576f3b6112a7da769a5a2201e27f967783f440c0f5f483b3fdd0c48::spig {
    struct SPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIG>(arg0, 6, b"SPIG", b"SUI PIG", b"SUIPIG is first PIG on TRON. Let's send this PIG to the moon together !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suipig_044abd7fa6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

