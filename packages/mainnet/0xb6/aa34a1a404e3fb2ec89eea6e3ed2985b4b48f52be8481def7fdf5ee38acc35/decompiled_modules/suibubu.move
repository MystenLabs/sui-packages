module 0xb6aa34a1a404e3fb2ec89eea6e3ed2985b4b48f52be8481def7fdf5ee38acc35::suibubu {
    struct SUIBUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBUBU>(arg0, 9, b"SUIBUBU", b"SUIBUBU", x"546869732069736ee2809974206a75737420616e6f74686572206d656d65636f696ee280a66974e28099732074686520736f756c206f6620535549207772617070656420696e2070757265206368616f7320616e6420637574656e6573732e0a4275696c7420666f7220646567656e732c20706f77657265642062792076696265732c206675656c656420627920636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBUBU>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBUBU>>(v2, @0xadb9c868098ed18500eb3b64827e278ddeab3ec09774190fd09cae357dbbef13);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBUBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

