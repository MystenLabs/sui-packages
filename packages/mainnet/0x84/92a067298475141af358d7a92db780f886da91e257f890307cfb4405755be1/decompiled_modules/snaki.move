module 0x8492a067298475141af358d7a92db780f886da91e257f890307cfb4405755be1::snaki {
    struct SNAKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAKI>(arg0, 6, b"SNAKI", b"SNAKI SUI", x"6c696c20736e616b69206368696c6c696e206f6e2061206173676172642773206772616e642068616c6c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/h0k_W4yg_400x400_66990e6790.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

