module 0x18e6c70f543473ccba3afad5d3dd6fa9662e063035efde0a1a23a18951457595::fking {
    struct FKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: FKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FKING>(arg0, 0, b"FKING", b"The Faceless KING", b"- An epic journey beyond the veil of perception -", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/MTXqWm04/FKING-LOGO-1.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FKING>(&mut v2, 88000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FKING>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

