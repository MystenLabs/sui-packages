module 0xf3854d1009f03b3b2a8bf50fc68628a535a8cda20ac4fbc348ddb5443bb52ac7::tea {
    struct TEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEA>(arg0, 9, b"TEA", b"Tara", b"Enjoying the finer things in life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.bing.com/images/create/rich-wife-that-you-can-only-see-from-behind-with-a/1-6708860c73e945f4a6f50cedb1380fae?id=v%2fUDC1Ngqfz3vpvTt0VDSw%3d%3d&view=detailv2&idpp=genimg&thId=OIG3.s7WrEW12ciVJuhQiriq9&skey=c11IY2ZmtQH2gy8YtAoKfRuzWVezNGzLrY4eXZ49aak&FORM=GCRIDP&mode=overlay")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEA>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

