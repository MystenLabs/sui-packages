module 0x4ce00ad8843389f0950d54de0fe2c6514d5027fbda43c1a0e2ed2e42475e1d15::suibg {
    struct SUIBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBG>(arg0, 6, b"TSUIBG", b"suibg", b"description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cdn.bitkeep.vip/u_b_696faaf0-c2f7-11ed-bb06-6b42bb500220.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBG>>(v1);
        0x2::coin::mint_and_transfer<SUIBG>(&mut v2, 100000000000000000, @0x4f8f207a0f1bc5f4ebf30ab73845b4655169c0055cf60fc52f31630d5e7114cc, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBG>>(v2, @0x4f8f207a0f1bc5f4ebf30ab73845b4655169c0055cf60fc52f31630d5e7114cc);
    }

    // decompiled from Move bytecode v6
}

