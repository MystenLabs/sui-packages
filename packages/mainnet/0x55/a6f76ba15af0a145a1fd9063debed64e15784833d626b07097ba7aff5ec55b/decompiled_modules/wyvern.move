module 0x55a6f76ba15af0a145a1fd9063debed64e15784833d626b07097ba7aff5ec55b::wyvern {
    struct WYVERN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WYVERN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WYVERN>(arg0, 9, b"wyvern", b"Wyvern", b"Mountain wyvern", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/807/075/large/rashx-jafarzade-vivern.jpg?1728562597")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WYVERN>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WYVERN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WYVERN>>(v1);
    }

    // decompiled from Move bytecode v6
}

