module 0xb9819bfb028fe6ec0e2ca2feb0e8b4de556b697e12f1df7bb44095d3ded22ada::iou {
    struct IOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: IOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IOU>(arg0, 9, b"IOU", b"IOU2", b"IOUUUUU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://search.app.goo.gl/X5cqB5L")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IOU>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IOU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

