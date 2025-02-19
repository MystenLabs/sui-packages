module 0xdce2057ab0d3288aeec1325f124b8073de59d4b1a177816dccd12081309576d9::hook {
    struct HOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOOK>(arg0, 9, b"HOOK", b"Hook", b"RUFIOOOOOOOOOOOOOOOOOOOOOOOOOO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/J1iUAXV.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOOK>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOOK>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

