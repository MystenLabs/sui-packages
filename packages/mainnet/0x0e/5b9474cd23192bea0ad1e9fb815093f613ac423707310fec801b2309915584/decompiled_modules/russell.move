module 0xe5b9474cd23192bea0ad1e9fb815093f613ac423707310fec801b2309915584::russell {
    struct RUSSELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSSELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSSELL>(arg0, 9, b"RUSSELL", b"RUSSELL", b"RUSSELL2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/pixar/images/9/96/Russell1.png/revision/latest?cb=20110416122426")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RUSSELL>(&mut v2, 6000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSSELL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUSSELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

