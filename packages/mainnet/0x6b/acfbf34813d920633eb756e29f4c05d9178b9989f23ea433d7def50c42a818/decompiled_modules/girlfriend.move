module 0x6bacfbf34813d920633eb756e29f4c05d9178b9989f23ea433d7def50c42a818::girlfriend {
    struct GIRLFRIEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIRLFRIEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIRLFRIEND>(arg0, 6, b"Girlfriend", b"Girlfriend of Sui", x"244749524c465249454e4420697320746865206f6e6520616e64206f6e6c792064697661206f662074686520537569204e6574776f726b2e2042656175746966756c2c20626f6c642c20616e6420616c7761797320737465616c696e67207468652073706f746c696768742e205368657320676f742074686520636861726d2074686174276c6c206b65657020796f7520686f6f6b65642e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_84_3b3ded7031.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIRLFRIEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIRLFRIEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

