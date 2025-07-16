module 0x611b595b92ca94e5d49fb7486214571b817bb925efa2c3cf85612fa350de5ce5::stars {
    struct STARS has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<STARS>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<STARS>>(0x2::coin::mint<STARS>(arg0, arg1, arg2), @0xc1cde08091a9a94b39cfbf90f48f276f41bbd05235138ff5634e31931c5a4869);
    }

    fun init(arg0: STARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARS>(arg0, 7, b"STARS", b"STARS Token", b"Stars point", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/0xobelisk/dubhe/main/assets/stars.gif")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<STARS>>(0x2::coin::mint<STARS>(&mut v2, 10000000000000000000, arg1), @0xc1cde08091a9a94b39cfbf90f48f276f41bbd05235138ff5634e31931c5a4869);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

