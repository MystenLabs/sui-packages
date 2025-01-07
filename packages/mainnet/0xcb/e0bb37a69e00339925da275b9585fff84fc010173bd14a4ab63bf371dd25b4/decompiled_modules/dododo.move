module 0xcbe0bb37a69e00339925da275b9585fff84fc010173bd14a4ab63bf371dd25b4::dododo {
    struct DODODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DODODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DODODO>(arg0, 9, b"DODODO", x"f09f909f446f646f646f", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DODODO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DODODO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DODODO>>(v1);
    }

    // decompiled from Move bytecode v6
}

