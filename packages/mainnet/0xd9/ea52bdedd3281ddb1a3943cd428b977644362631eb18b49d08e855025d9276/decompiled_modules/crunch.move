module 0xd9ea52bdedd3281ddb1a3943cd428b977644362631eb18b49d08e855025d9276::crunch {
    struct CRUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRUNCH>(arg0, 6, b"CRUNCH", b"Crunchycat", x"4372756e63687963617420284352554e4348290a4372756e63687963617420697320746865206372756e63686965737420636174206f6e205375692120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2222_3bf2b84713.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRUNCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRUNCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

