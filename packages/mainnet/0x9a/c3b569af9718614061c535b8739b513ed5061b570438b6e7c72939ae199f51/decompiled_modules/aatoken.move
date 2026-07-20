module 0x9ac3b569af9718614061c535b8739b513ed5061b570438b6e7c72939ae199f51::aatoken {
    struct AATOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AATOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AATOKEN>(arg0, 9, b"AAT", b"AAtoken", b"A token created for Cetus and Bluefin pool testing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/200x200/20947.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AATOKEN>>(0x2::coin::mint<AATOKEN>(&mut v2, 1000000000000000000, arg1), v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AATOKEN>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AATOKEN>>(v1);
    }

    // decompiled from Move bytecode v7
}

