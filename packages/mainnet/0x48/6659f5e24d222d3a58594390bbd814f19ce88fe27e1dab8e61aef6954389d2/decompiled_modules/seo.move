module 0x486659f5e24d222d3a58594390bbd814f19ce88fe27e1dab8e61aef6954389d2::seo {
    struct SEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEO>(arg0, 9, b"SEO", b"SEO PUMP", b"SEO PUMP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SEO>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

