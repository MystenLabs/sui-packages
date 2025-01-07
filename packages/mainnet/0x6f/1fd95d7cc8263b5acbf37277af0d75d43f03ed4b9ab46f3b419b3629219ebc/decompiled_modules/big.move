module 0x6f1fd95d7cc8263b5acbf37277af0d75d43f03ed4b9ab46f3b419b3629219ebc::big {
    struct BIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIG>(arg0, 9, b"BIG", b"SUIBIG", b"big on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIG>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

