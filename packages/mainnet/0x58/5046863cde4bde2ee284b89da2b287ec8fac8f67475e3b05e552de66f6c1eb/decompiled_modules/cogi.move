module 0x585046863cde4bde2ee284b89da2b287ec8fac8f67475e3b05e552de66f6c1eb::cogi {
    struct COGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: COGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COGI>(arg0, 9, b"COGi", b"COGi Inu", b"New Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.bing.com/images/create/cogi-meme-with-sunglasses-holding-an-ice-cream-con/1-664d890a3c8e4e94ac26de97fa3f6807?id=n4jut87uzrRkT30y3b%2FD3w%3D%3D&view=detailv2&idpp=genimg&noidpclose=1&thId=OIG2.RbgsZPsgbZIGzSUcnv26&FORM=SYDBIC&ssp=1&darkschemeovr=1&safesearch=moderate&setlang=en&cc=XL&PC=SANSAAND")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COGI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COGI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

