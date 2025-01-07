module 0x9a623f511661f77e2f790f8ba6e3aad08cab6859f3d28daa784d3eb26b18d41d::birds {
    struct BIRDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDS>(arg0, 9, b"Birds", b"Birds", b"Birds", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BIRDS>>(0x2::coin::mint<BIRDS>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIRDS>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BIRDS>>(v2);
    }

    // decompiled from Move bytecode v6
}

