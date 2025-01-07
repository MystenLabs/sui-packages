module 0xf1ef78aaaccb3f4a610a8b3772f525d53c21a20bbd547db40166e8fcff84b801::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROG>(arg0, 6, b"FROG", b"ForRealOG", x"46524f472050455045202f0a636f6d6d756e6974792072756e2f0a63756c74757265202b206d656d6573203d207669626573202f0a706f73742026205254206d656d65732e206f7468657220737475666620746f6f202f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/311_91a804227e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

