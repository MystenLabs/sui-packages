module 0xcda04515fdd9f40fc440b6509477d69e29b04130b735ca641d2bd087bfd09b6f::suidy {
    struct SUIDY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIDY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIDY>>(0x2::coin::mint<SUIDY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUIDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDY>(arg0, 4, b"SUIDY", b"shik", b"ghr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"blob:https://release.d1a08k84dqyiru.amplifyapp.com/656f2b2b-85be-426b-81e3-6a1134ee565f"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIDY>>(0x2::coin::mint<SUIDY>(&mut v2, 0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

