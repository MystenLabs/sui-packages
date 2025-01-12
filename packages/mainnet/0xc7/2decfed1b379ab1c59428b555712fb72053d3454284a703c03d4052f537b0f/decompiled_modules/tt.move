module 0xc72decfed1b379ab1c59428b555712fb72053d3454284a703c03d4052f537b0f::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT>(arg0, 9, b"TT", b"Test Token", b"Test Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreic5rvww44r365h66omnrhxft5fsz7v4cliq45xbiv4d4g7isbl7sm?X-Algorithm=PINATA1&X-Date=1736583178&X-Expires=315360000&X-Method=GET&X-Signature=489a0fb0db8f3b12429cd3a8588ae55bf4190bd409ea751664e904c026ecb714"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TT>>(v2);
    }

    // decompiled from Move bytecode v6
}

