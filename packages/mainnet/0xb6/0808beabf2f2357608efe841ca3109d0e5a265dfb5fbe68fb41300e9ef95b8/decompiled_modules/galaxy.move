module 0xb60808beabf2f2357608efe841ca3109d0e5a265dfb5fbe68fb41300e9ef95b8::galaxy {
    struct GALAXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GALAXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GALAXY>(arg0, 9, b"GALAXY", b"SuiGalaxy", b"SuiGalaxy is a meme token inspired by the boundless potential of space, symbolizing limitless growth within the Sui ecosystem. It invites holders on an exciting journey through the crypto universe, with infinite opportunities waiting to be explored. Perfect for those looking to soar to new heights during the next super cycle.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1801291786255478784/XGwVuc6U.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GALAXY>(&mut v2, 220000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GALAXY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GALAXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

