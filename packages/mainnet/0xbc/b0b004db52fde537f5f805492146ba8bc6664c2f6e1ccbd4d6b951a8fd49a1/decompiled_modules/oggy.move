module 0xbcb0b004db52fde537f5f805492146ba8bc6664c2f6e1ccbd4d6b951a8fd49a1::oggy {
    struct OGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGY>(arg0, 9, b"OGGY", b"Sui Oggy", b"I am the best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/media/GZX8j2IWMAABwyv?format=jpg&name=medium"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGGY>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OGGY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGGY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

