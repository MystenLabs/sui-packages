module 0xb9b1ec2d50e49f63b87661acc79c146a4d0d5429b076a84dec79d9b0e6c8ddf5::sui_penguin {
    struct SUI_PENGUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_PENGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_PENGUIN>(arg0, 9, b"SUI PENGUIN", x"f09f90a75375692050656e6775696e", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_PENGUIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_PENGUIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_PENGUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

