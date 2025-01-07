module 0x3b7483fea8bde9a019ec20c59b1c721f011a453af8baf5437d90710e26355e49::suixaf {
    struct SUIXAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIXAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIXAF>(arg0, 9, b"SuixAF", b"The SuixAF", b"This is SuixAF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ichef.bbci.co.uk/ace/standard/976/cpsprodpb/16620/production/_91408619_55df76d5-2245-41c1-8031-07a4da3f313f.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIXAF>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIXAF>>(v2, @0x9d01d9f7b776e75a1a63c5561b68d68c302e232ce91abbd105e6897ebaae19fa);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIXAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

