module 0x8f06db3e177d11d26d1763d73b36c98c2e4c3f7f963324d8504aa8d8b05e1562::nug {
    struct NUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUG>(arg0, 9, b"NUG", b"Nugget", b"I'm a nugget", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media1.tenor.com/m/CjfqlOScovQAAAAd/roblox-nugget-roblox-man-face.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NUG>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUG>>(v2, @0xc5f9b77a07c38acc5418008dfe69255872d45e3d2334e1f52a530d1e4ad52866);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

