module 0xd016bbadc3edebc7c873ec2e74469da448aacd6bc3d871b395ef0e692723d66f::fortunepaper {
    struct FORTUNEPAPER has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let v0 = if (b"https://dxzj0lxt4bkn6mwx.public.blob.vercel-storage.com/ludo-logo-tbrBJP7fNmZjCldmhd5IUVvCxpJ4e8.png" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dxzj0lxt4bkn6mwx.public.blob.vercel-storage.com/ludo-logo-tbrBJP7fNmZjCldmhd5IUVvCxpJ4e8.png"))
        };
        let (v1, v2) = 0x2::coin::create_currency<T0>(arg0, 18, b"FORTUNE", b"Fortune paper", b"The following contract regulates the functioning of  Loyalty Tokens", v0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v2);
        v1
    }

    fun init(arg0: FORTUNEPAPER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<FORTUNEPAPER>(arg0, arg1);
        let (v1, v2) = 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::new_policy<FORTUNEPAPER>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0x14a13c8ff92114f3c3718042eb5937cccf76d9b5d67509d880a5df2a9f07bf90::core::set_rules<FORTUNEPAPER>(&mut v4, &v3, arg1);
        0x14a13c8ff92114f3c3718042eb5937cccf76d9b5d67509d880a5df2a9f07bf90::core::create_registry<FORTUNEPAPER>(v0, v3, true, arg1);
        0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::share_policy<FORTUNEPAPER>(v4);
    }

    // decompiled from Move bytecode v6
}

