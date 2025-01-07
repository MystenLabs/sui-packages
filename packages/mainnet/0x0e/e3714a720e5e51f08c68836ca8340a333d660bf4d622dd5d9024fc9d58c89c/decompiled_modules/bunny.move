module 0xee3714a720e5e51f08c68836ca8340a333d660bf4d622dd5d9024fc9d58c89c::bunny {
    struct BUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNNY>(arg0, 9, b"BUNNY", b"Mecha Bunny", b"Mecha Bunny squad \"SMITH 83\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/729/403/large/veronika-emerald-face3.jpg?1728372536")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUNNY>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNNY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

