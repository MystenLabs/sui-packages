module 0x16a2d0f7cfacd407dab08e28fbbb60c02556db0106d445d8472fd4dc03f3bec4::pui {
    struct PUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUI>(arg0, 6, b"PUI", b"Pupupui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://resize.cdn.otakumode.com/ex/1200.1200/shop/product/6cde7248a8bb4cd9a80324f00032ac65.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUI>(&mut v2, 8888888889000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

