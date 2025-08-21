module 0x5d81ca102989eed58e9481a7f20d4dfa58f798a1eac4f9bccdf78fedb16cde15::GOBBY {
    struct GOBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOBBY>(arg0, 6, b"Goblin Gold", b"GOBBY", b"A mischievous meme coin for those who love chaos, treasure, and a little bit of goblin magic. GOBBY is the currency of the underground, where every hodler is part of the goblin horde. Warning: may cause sudden urges to hoard shiny things and raid villages.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreierl2n6wf6rrdml5qbbiqs45ldewvghoeh2mrobhlgfoxt27qeleu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOBBY>>(v0, @0x2be6c850562754e11af55b7f049f4e304e488dff630b3832874d80c837c458a8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOBBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

