module 0x5a4e4b83a3f4acede137865d878774df7682d770c8139ea00d9f82849249bd9c::trmp {
    struct TRMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRMP>(arg0, 9, b"TRMP", b"TRUMP", b"Donald Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.natgeofe.com/k/5e4ea67e-2219-4de4-9240-2992faef0cb6/trump-portrait.jpg?wp=1&w=1084.125&h=1068.375")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRMP>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

