module 0x5888e704ab431af304a9db103d457150418904870672d94d4ad76db6422aeb9::suixag {
    struct SUIXAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIXAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIXAG>(arg0, 9, b"SuixAG", b"The SuixAG", b"This is SuixAG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ichef.bbci.co.uk/ace/standard/976/cpsprodpb/16620/production/_91408619_55df76d5-2245-41c1-8031-07a4da3f313f.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIXAG>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIXAG>>(v2, @0x9d01d9f7b776e75a1a63c5561b68d68c302e232ce91abbd105e6897ebaae19fa);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIXAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

