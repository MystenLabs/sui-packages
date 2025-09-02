module 0x8848f166940d7471f067ea26d8e8adedaeda9a44d44d0e692e09d2db915398b3::ssol {
    struct SSOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSOL>(arg0, 6, b"SSOL", b"SSOL", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSOL>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSOL>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSOL>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

