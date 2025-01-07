module 0x2b6029aed83bb8357b9633bc91b8d35b4a0833d594d4ff747463b6fd5990b9c9::Sai {
    struct SAI has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: &mut 0x2::coin::Coin<SAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SAI>>(0x2::coin::split<SAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAI>(arg0, 6, b"SAI", b"Sui AI", b"AI layer on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/fyP2pbj9/sai.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SAI>>(0x2::coin::mint<SAI>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SAI>>(v2);
    }

    // decompiled from Move bytecode v6
}

