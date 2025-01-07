module 0x709377cdb113c39a79b721d786566950ca63d49457b79ef6635ec3ed4eabaa0c::coco {
    struct COCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCO>(arg0, 9, b"COCO", b"Coco", b"Coco launch on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://e7.pngegg.com/pngimages/1005/487/png-clipart-coco-illustration-illustration-mama-coco-pixar-drawing-ernesto-de-la-cruz-mama-coco-cartoon-fictional-character-thumbnail.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COCO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

