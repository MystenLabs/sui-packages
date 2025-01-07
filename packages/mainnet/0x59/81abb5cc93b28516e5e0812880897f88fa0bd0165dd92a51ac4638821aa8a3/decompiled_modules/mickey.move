module 0x5981abb5cc93b28516e5e0812880897f88fa0bd0165dd92a51ac4638821aa8a3::mickey {
    struct MICKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICKEY>(arg0, 9, b"MICKEY", b"Mickey", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/disney/images/a/a8/Mickey-mouse35.png/revision/latest/smart/width/250/height/250?cb=20221116202148&path-prefix=es")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MICKEY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICKEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MICKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

