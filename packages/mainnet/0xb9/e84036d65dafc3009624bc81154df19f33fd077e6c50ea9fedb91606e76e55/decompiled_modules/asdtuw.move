module 0xb9e84036d65dafc3009624bc81154df19f33fd077e6c50ea9fedb91606e76e55::asdtuw {
    struct ASDTUW has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDTUW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDTUW>(arg0, 9, b"ASDTUW", b"AwesomeToken", b"This is a test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASDTUW>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDTUW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASDTUW>>(v1);
    }

    // decompiled from Move bytecode v6
}

