module 0xcb3a31d5dfda3b5f6f7c1d1e0a0b43413f549bc0116cf5e1e82e4f86041a66be::isc {
    struct ISC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISC>(arg0, 1, b"ISC", b"Iscander", b"Iscander token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/98e366c3-c334-4495-b555-756dff8f28a2.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ISC>(&mut v2, 10000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISC>>(v1);
    }

    // decompiled from Move bytecode v6
}

