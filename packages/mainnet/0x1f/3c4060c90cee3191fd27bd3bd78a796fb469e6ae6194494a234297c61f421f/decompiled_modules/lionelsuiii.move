module 0x1f3c4060c90cee3191fd27bd3bd78a796fb469e6ae6194494a234297c61f421f::lionelsuiii {
    struct LIONELSUIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIONELSUIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIONELSUIII>(arg0, 9, b"LIONELSUIII", b"Lionel Suiiii", b"messi offcial off token on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.mykhel.com/thumb/250x90x250/football/players/4/19054.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LIONELSUIII>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIONELSUIII>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIONELSUIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

