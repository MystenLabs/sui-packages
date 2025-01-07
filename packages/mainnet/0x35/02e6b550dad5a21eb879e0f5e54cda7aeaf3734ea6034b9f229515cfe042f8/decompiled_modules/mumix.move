module 0x3502e6b550dad5a21eb879e0f5e54cda7aeaf3734ea6034b9f229515cfe042f8::mumix {
    struct MUMIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUMIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUMIX>(arg0, 9, b"MUMIX", b"MUMI", b"MUMIS IS BEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MUMIX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUMIX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUMIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

