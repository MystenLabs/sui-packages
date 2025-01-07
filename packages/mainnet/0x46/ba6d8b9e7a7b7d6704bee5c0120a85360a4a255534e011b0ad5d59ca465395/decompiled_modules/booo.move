module 0x46ba6d8b9e7a7b7d6704bee5c0120a85360a4a255534e011b0ad5d59ca465395::booo {
    struct BOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOO>(arg0, 9, b"BOOo", b"BOO", b"Official token of boo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/diceblock/images/d/da/600px-BooNSMBWii-1-.png/revision/latest/scale-to-width-down/250?cb=20181109170546")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOOO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

