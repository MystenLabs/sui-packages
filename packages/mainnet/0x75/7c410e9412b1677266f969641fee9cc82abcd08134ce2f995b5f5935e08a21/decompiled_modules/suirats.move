module 0x757c410e9412b1677266f969641fee9cc82abcd08134ce2f995b5f5935e08a21::suirats {
    struct SUIRATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRATS>(arg0, 9, b"SUIRATS", b"Sui Rats", b"Sui Rats Sui Community Real Meme Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1828322581814099968/AFR0Ubqh_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIRATS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRATS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

