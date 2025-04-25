module 0x514add90dbd71d4fe4ee5d396cc9459b9b499c2834570573d3cc9c11fdce938d::vun {
    struct VUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VUN>(arg0, 6, b"VUN", b"VUNDIO APP", x"56756e64696f20697320616e20414920706f7765726564204e46542067656e657261746f722c20696e746567726174656420776974682023535549204e45542e20536c65656b2064657369676e20616e64207573657220667269656e646c79206665617475726573206d616b652074686520657870657269656e636520656e6a6f7961626c6520616e6420656666696369656e742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_04_25_22_41_00_791fa8f788.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

