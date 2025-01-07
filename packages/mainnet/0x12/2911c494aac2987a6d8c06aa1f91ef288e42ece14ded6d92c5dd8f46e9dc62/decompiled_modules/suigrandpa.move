module 0x122911c494aac2987a6d8c06aa1f91ef288e42ece14ded6d92c5dd8f46e9dc62::suigrandpa {
    struct SUIGRANDPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGRANDPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGRANDPA>(arg0, 9, b"suigrandpa", b"Suigrandpa", b"grandpa of suiman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGRANDPA>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGRANDPA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGRANDPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

