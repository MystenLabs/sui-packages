module 0xcb7d7f7448050b8fee92265d45c55fb9821d006428f391a9e8fbd26ff154ce34::agro {
    struct AGRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGRO>(arg0, 2, b"AGRO", b"AGROX", b"First cryptocurrency used as parity in agribusiness.  Our main idea is to make life easier for those who sell and those who buy, without the influence of the dollar and totally decentralized from banks. countries around the world will finally lose this dollar dependence", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AGRO>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGRO>>(v2, @0x2cf5b6c2760c493dd9198fd9b57df03e8f45f55b4ccad6bf2a93c9778ac56ed);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

