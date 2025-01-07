module 0xdd19c9d9ae58e29fd9823a77d6b5c32e26775e1f5e3c390ff00dc7078aa1a66::sui_neiro {
    struct SUI_NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_NEIRO>(arg0, 9, b"Sui Neiro", b"Sui Neiro", b"Sui Neiroooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://framerusercontent.com/images/4mw5jbqvu6qrOu6kJ7Nni6VXJs.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_NEIRO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_NEIRO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_NEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

