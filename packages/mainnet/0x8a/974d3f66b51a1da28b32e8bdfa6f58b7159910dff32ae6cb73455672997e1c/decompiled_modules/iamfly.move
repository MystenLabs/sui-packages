module 0x8a974d3f66b51a1da28b32e8bdfa6f58b7159910dff32ae6cb73455672997e1c::iamfly {
    struct IAMFLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IAMFLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IAMFLY>(arg0, 6, b"IAMFLY", b"Fly Pengu", b"The only Pengu that will FLY.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007571_5ea119102e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IAMFLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IAMFLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

