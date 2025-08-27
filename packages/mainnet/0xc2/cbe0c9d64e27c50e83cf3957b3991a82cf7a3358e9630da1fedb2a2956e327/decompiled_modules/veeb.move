module 0xc2cbe0c9d64e27c50e83cf3957b3991a82cf7a3358e9630da1fedb2a2956e327::veeb {
    struct VEEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: VEEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VEEB>(arg0, 9, b"veeb", b"veeb", b"efficiency and productivity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VEEB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VEEB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VEEB>>(v1);
    }

    // decompiled from Move bytecode v6
}

