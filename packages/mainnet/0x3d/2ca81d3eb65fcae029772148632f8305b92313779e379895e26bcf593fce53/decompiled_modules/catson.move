module 0x3d2ca81d3eb65fcae029772148632f8305b92313779e379895e26bcf593fce53::catson {
    struct CATSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSON>(arg0, 6, b"CATSON", b"Catson On Sui", b"Catson a new memecoin with utility, and make your money safe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Black_and_White_House_Real_Estate_Logo_20250430_023257_0000_468281c67a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

