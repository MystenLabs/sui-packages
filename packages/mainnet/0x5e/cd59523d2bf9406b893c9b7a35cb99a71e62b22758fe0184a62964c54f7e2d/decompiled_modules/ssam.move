module 0x5ecd59523d2bf9406b893c9b7a35cb99a71e62b22758fe0184a62964c54f7e2d::ssam {
    struct SSAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSAM>(arg0, 9, b"SSAM", b"SAM", b"SSAM - Sui Man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://goods-photos.static1-sima-land.com/items/7175055/1/700-nw.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSAM>(&mut v2, 21000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSAM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

