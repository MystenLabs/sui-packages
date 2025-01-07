module 0x2ee8a1b10ae0037da0c254ffedea2848b97f691b344cd4832e50123c5d922c6b::booooolooo {
    struct BOOOOOLOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOOOOLOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOOOOLOOO>(arg0, 9, b"BOOooolooo", b"BOO", b"Official token of boo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/diceblock/images/d/da/600px-BooNSMBWii-1-.png/revision/latest/scale-to-width-down/250?cb=20181109170546")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOOOOOLOOO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOOOOLOOO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOOOOLOOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

