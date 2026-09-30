module 0xff2c6cb3777aa31b986c5d94c6a7f386ba8ff554c6def5b003a6b6ac761312ef::fuk {
    struct FUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUK>(arg0, 9, b"Fuk", b"Fuk Zuk", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fartpadsui.fun/token-images/fuk.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FUK>>(0x2::coin::mint<FUK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUK>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

