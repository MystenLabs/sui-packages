module 0xfc7cd0f6d813e27621295d0120fd750fc1d14b006c2c7c11ed2570ba682dd4c0::suikemon {
    struct SUIKEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKEMON>(arg0, 6, b"Suikemon", b"Catch them all on SUI", b"Can you catch all the suikemon. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2_0a29795607.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKEMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKEMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

