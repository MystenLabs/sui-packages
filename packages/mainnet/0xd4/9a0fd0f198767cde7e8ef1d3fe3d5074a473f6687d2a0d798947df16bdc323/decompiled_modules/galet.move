module 0xd49a0fd0f198767cde7e8ef1d3fe3d5074a473f6687d2a0d798947df16bdc323::galet {
    struct GALET has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GALET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GALET>>(0x2::coin::mint<GALET>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GALET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GALET>(arg0, 9, b"GALET", b"GALET", b"GALET is the community token for the French-speaking Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/4NvJSRm2/galet.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GALET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GALET>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

