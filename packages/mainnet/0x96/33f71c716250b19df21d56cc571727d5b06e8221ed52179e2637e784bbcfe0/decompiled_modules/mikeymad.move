module 0x9633f71c716250b19df21d56cc571727d5b06e8221ed52179e2637e784bbcfe0::mikeymad {
    struct MIKEYMAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKEYMAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKEYMAD>(arg0, 9, b"MIKEYMAD", b"Mikey Madison", b"Born: March 25, 1999, Los Angeles, CA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a1.moviepassblack.com/w3/assets/MIKEYMAD.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIKEYMAD>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKEYMAD>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIKEYMAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

