module 0x567b61f081b7c7b72064b69916f66090520a30ceb85d15baf131a43af1e252fd::qqq {
    struct QQQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: QQQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QQQ>(arg0, 9, b"QQQ", b"qqq", b"qqq", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreic5rvww44r365h66omnrhxft5fsz7v4cliq45xbiv4d4g7isbl7sm?X-Algorithm=PINATA1&X-Date=1736744514&X-Expires=315360000&X-Method=GET&X-Signature=86ddaeb3a2094269dbc20e378462cfbff7ae960525b06b406d2065a514aa7cd8"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<QQQ>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QQQ>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<QQQ>>(v2);
    }

    // decompiled from Move bytecode v6
}

