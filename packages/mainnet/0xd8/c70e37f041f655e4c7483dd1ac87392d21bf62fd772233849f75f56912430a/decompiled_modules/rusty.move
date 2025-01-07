module 0xd8c70e37f041f655e4c7483dd1ac87392d21bf62fd772233849f75f56912430a::rusty {
    struct RUSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSTY>(arg0, 6, b"RUSTY", b"RUSTY on SUI", b"\"Rusty\" is a meme coin featuring a charming red panda character equipped with aviator goggles and a jetpack, ready to soar through the skies of the crypto world. Rusty embodies a spirit of adventure and innovation, appealing to those who appreciate a mix of cute design and high-flying ambition.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rusty_3cefdf7971.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUSTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

