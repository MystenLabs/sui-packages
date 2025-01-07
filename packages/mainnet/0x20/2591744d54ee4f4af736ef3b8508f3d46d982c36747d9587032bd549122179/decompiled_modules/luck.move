module 0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck {
    struct LUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCK>(arg0, 9, b"LUCK", b"LUCKYSTAR", b"LUCKYSTAR TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://luckystar-web.s3.ap-southeast-1.amazonaws.com/starlogo.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUCK>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LUCK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<LUCK>>(0x2::coin::mint<LUCK>(&mut v2, 4000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

