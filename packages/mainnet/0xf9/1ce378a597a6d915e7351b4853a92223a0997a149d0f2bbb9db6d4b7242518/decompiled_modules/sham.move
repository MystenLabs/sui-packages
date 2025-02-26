module 0xf91ce378a597a6d915e7351b4853a92223a0997a149d0f2bbb9db6d4b7242518::sham {
    struct SHAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAM>(arg0, 9, b"SHAM", b"Shamrock Coin", b"A coin for good luck!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHAM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

