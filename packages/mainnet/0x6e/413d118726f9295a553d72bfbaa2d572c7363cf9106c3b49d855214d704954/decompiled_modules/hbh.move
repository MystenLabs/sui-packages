module 0x6e413d118726f9295a553d72bfbaa2d572c7363cf9106c3b49d855214d704954::hbh {
    struct HBH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBH>(arg0, 9, b"HBH", b"HBH", b"HHHBBBB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.app.goo.gl/hcfBe8DhY4wNP9Yu8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HBH>(&mut v2, 5000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HBH>>(v1);
    }

    // decompiled from Move bytecode v6
}

