module 0xedd9e032e83ed2e9d2f62e057654d7b7289d0bf825e209310ac95d0c48cfba8::yayaya {
    struct YAYAYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAYAYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAYAYA>(arg0, 9, b"YAYAYA", b"YAYA", b"YAYAYAY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.app.goo.gl/hcfBe8DhY4wNP9Yu8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YAYAYA>(&mut v2, 34543433463000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAYAYA>>(v2, @0x2aa07bfc753ea8fb7136b7e9466fe8aa26eff057087809b4c408e1cf5acc35ff);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAYAYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

