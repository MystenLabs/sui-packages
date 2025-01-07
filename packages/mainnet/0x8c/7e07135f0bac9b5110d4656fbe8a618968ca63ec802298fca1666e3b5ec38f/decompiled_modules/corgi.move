module 0x8c7e07135f0bac9b5110d4656fbe8a618968ca63ec802298fca1666e3b5ec38f::corgi {
    struct CORGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORGI>(arg0, 9, b"CORGI", b"CorgiAI", b"CorgiAI is a compact, catchy token name combining the playful appeal of corgis with the intelligence of AI, perfect for a fun, innovative project in the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1558902252395438083/f3AErap4.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CORGI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORGI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CORGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

