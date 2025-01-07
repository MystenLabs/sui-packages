module 0x91eae7ccabecaf6d90fca11ce9193797862454f4306875b39c8fc1b9ac48d771::the_diddy {
    struct THE_DIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: THE_DIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THE_DIDDY>(arg0, 9, b"THE DIDDY", b"SEAN COMBS", b"p diddy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<THE_DIDDY>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THE_DIDDY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THE_DIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

