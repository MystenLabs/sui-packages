module 0xc9b3c52c7245648bd4724cad2c4e662648bc5946ac85cd93b8dfc73a7c7fe81::suishiba {
    struct SUISHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIBA>(arg0, 5, b"SUISHIBA", b"SuiShiba", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1652612936764997633/fHY1LNIz_400x400.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SUISHIBA>(&mut v2, 10000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIBA>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

