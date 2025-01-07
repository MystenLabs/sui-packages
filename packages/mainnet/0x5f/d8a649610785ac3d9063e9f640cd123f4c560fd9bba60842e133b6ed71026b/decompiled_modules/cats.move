module 0x5fd8a649610785ac3d9063e9f640cd123f4c560fd9bba60842e133b6ed71026b::cats {
    struct CATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATS>(arg0, 9, b"CATS", b"Sui Cats", b"Cats Is Meme On Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844812083801845760/P3i-jFYe.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CATS>(&mut v2, 465000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

