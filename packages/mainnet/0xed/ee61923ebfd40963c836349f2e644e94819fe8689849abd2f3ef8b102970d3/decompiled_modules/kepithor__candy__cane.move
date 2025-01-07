module 0xedee61923ebfd40963c836349f2e644e94819fe8689849abd2f3ef8b102970d3::kepithor__candy__cane {
    struct KEPITHOR__CANDY__CANE has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let v0 = if (b"https://dxzj0lxt4bkn6mwx.public.blob.vercel-storage.com/Candy%20Cane-jX0koP16fJHviqH71id2LdJF3st8E2.jfif" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dxzj0lxt4bkn6mwx.public.blob.vercel-storage.com/Candy%20Cane-jX0koP16fJHviqH71id2LdJF3st8E2.jfif"))
        };
        let (v1, v2) = 0x2::coin::create_currency<T0>(arg0, 18, b"CANE", b"Candy Cane", b"The following contract regulates the functioning of Kepithor Loyalty Tokens", v0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v2);
        v1
    }

    fun init(arg0: KEPITHOR__CANDY__CANE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<KEPITHOR__CANDY__CANE>(arg0, arg1);
        let (v1, v2) = 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::new_policy<KEPITHOR__CANDY__CANE>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0x14a13c8ff92114f3c3718042eb5937cccf76d9b5d67509d880a5df2a9f07bf90::core::set_rules<KEPITHOR__CANDY__CANE>(&mut v4, &v3, arg1);
        0x14a13c8ff92114f3c3718042eb5937cccf76d9b5d67509d880a5df2a9f07bf90::core::create_registry<KEPITHOR__CANDY__CANE>(v0, v3, true, arg1);
        0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::share_policy<KEPITHOR__CANDY__CANE>(v4);
    }

    // decompiled from Move bytecode v6
}

