module 0x7bf4c6013b747eea7a0db8cfa6fc7a841075e341f220ef64fe3306b8b854b57d::dogiz {
    struct DOGIZ has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: 0x2::coin::Coin<DOGIZ>) {
        0x2::coin::destroy_zero<DOGIZ>(arg0);
    }

    fun init(arg0: DOGIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGIZ>(arg0, 6, b"DOGIZ", b"Dogizen", b"Dogizen Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dogizen.io/logo.webp")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGIZ>>(0x2::coin::mint<DOGIZ>(&mut v2, 1000000000000000000, arg1), @0x2f48ddfe95d79bafa699130f1336a31c66284032891b5b1c6a17840e1d9251bd);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGIZ>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGIZ>>(v2);
    }

    // decompiled from Move bytecode v6
}

