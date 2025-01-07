module 0x7b26efbed9993704aa6adebce27fffeccaa120366ecdbba7752e0a3c0833279d::cib {
    struct CIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIB>(arg0, 9, b"CiB", b"cat in boots", b"New and fun coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.bing.com/images/create/cat-in-boots/1-66daf0e54c504db1ba87710a76865e1d?id=%2bcn9PNJNoCzvP%2bSY8QWZkg%3d%3d&view=detailv2&idpp=genimg&thId=OIG2.WemyEGIW.ARTzhFeJz9w&skey=KteQ_SpGrTZq7XkDCu1t2o8QsA5pDLRnY-AX63EkPT0&FORM=GCRIDP&ajaxhist=0&ajaxserp=0")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CIB>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIB>>(v2, @0xd064b84679fa696a1961cd27c417081f3a835decda3a7841cfbbcfbf985317b3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

