module 0xd275caaa1d0e762251ce6b989e0b2b0f122be276894c36bed92eddcfb763417::twiskers {
    struct TWISKERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWISKERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWISKERS>(arg0, 6, b"TWISKERS", b"Twiskers Monster", b"Better watch out, cause Im here to conquer all the memes with my fluff and claws, nya.Buybot added.Dexscreener cooking.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/Twiskers_Token_1_150x150_e56ec8cd5d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWISKERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWISKERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

