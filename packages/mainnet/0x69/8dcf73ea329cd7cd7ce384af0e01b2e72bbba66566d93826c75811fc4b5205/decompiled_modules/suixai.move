module 0x698dcf73ea329cd7cd7ce384af0e01b2e72bbba66566d93826c75811fc4b5205::suixai {
    struct SUIXAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIXAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIXAI>(arg0, 9, b"SuixAI", b"The SuixAI", b"This is SuixAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ichef.bbci.co.uk/ace/standard/976/cpsprodpb/16620/production/_91408619_55df76d5-2245-41c1-8031-07a4da3f313f.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIXAI>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIXAI>>(v2, @0x9d01d9f7b776e75a1a63c5561b68d68c302e232ce91abbd105e6897ebaae19fa);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIXAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

