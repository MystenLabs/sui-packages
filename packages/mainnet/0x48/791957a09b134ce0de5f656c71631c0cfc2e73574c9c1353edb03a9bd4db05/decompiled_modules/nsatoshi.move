module 0x48791957a09b134ce0de5f656c71631c0cfc2e73574c9c1353edb03a9bd4db05::nsatoshi {
    struct NSATOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSATOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSATOSHI>(arg0, 6, b"NSATOSHI", b"Not Satoshi", x"446566696e6974656c79204e6f74205361746f7368690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/_bab8e12d79.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSATOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NSATOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

