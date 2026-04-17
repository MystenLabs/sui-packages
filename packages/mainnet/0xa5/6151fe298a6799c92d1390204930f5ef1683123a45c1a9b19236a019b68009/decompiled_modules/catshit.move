module 0xa56151fe298a6799c92d1390204930f5ef1683123a45c1a9b19236a019b68009::catshit {
    struct CATSHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776434007102-58f17873cdbc8daf2e7670bfbebab45e.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776434007102-58f17873cdbc8daf2e7670bfbebab45e.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<CATSHIT>(arg0, 9, b"CATSHIT", b"Catshit SUI", b"the catshit on sui it's live no cry no drama no promisses", v1, arg1);
        let v4 = v2;
        if (10000000000000000 > 0) {
            0x2::coin::mint_and_transfer<CATSHIT>(&mut v4, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSHIT>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATSHIT>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

