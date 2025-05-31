module 0xe4c46e6000b8556b70189f88d11ee5e986a2906c36bf18d91a2016aadafda34c::b_bluey {
    struct B_BLUEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BLUEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BLUEY>(arg0, 9, b"bBLUEY", b"bToken BLUEY", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BLUEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BLUEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

