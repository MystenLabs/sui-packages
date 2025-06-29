module 0xe1788f20df30e20a7800d8720ccc1fdf9a66b8c1b230005f423447be7b37963d::g8d {
    struct G8D has drop {
        dummy_field: bool,
    }

    fun init(arg0: G8D, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<G8D>(arg0, 8, b"G8D", b"G8D", x"65726520636f6d657320796f757220414920466f7274756e652054656c6c6572206261636b6564206279200a40626e62636861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/bb0400b3-d64f-4188-9511-5d76d3d4e720.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<G8D>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<G8D>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<G8D>>(v1);
    }

    // decompiled from Move bytecode v6
}

