module 0xd418b823b557a729a8a7e269e7f2d37a09ff5d092688e12d42df2fa44a3aa9ef::www {
    struct WWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWW>(arg0, 9, b"WWW", b"www", b"www", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreic5rvww44r365h66omnrhxft5fsz7v4cliq45xbiv4d4g7isbl7sm?X-Algorithm=PINATA1&X-Date=1736745027&X-Expires=315360000&X-Method=GET&X-Signature=248153197dbfa74a29674313809f67e0d4119d6dbb25d290ab3fc99e7b2f1f47"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WWW>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWW>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WWW>>(v2);
    }

    // decompiled from Move bytecode v6
}

