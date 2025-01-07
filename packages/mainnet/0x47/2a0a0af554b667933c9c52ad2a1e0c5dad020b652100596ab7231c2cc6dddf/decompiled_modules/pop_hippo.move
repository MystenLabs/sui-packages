module 0x472a0a0af554b667933c9c52ad2a1e0c5dad020b652100596ab7231c2cc6dddf::pop_hippo {
    struct POP_HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POP_HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POP_HIPPO>(arg0, 9, b"POP HIPPO", b"POP HIPPO", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/tinyfarm/images/a/a0/Pink_Hippo.png/revision/latest/scale-to-width-down/250?cb=20210426201128")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POP_HIPPO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POP_HIPPO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POP_HIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

