module 0xdd857b8e45fa28edd16874067e530d663eaf37a0923eef77b697eb80ab1dbaf4::intel {
    struct INTEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: INTEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INTEL>(arg0, 9, b"INTEL", b"INTEL", b"Intel Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<INTEL>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INTEL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INTEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

