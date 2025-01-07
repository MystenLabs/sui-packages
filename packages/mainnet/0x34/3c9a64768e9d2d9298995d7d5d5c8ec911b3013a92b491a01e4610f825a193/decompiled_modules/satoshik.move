module 0x343c9a64768e9d2d9298995d7d5d5c8ec911b3013a92b491a01e4610f825a193::satoshik {
    struct SATOSHIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOSHIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOSHIK>(arg0, 9, b"SATOSHIK", b"Satoshi Scamomoto", b"Satoshi Nakamoto is the pseudonym of the person who created Bitcoin and wrote its foundational paper in 2008. Their true identity remains unknown.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.coindesk.com/resizer/x9N8qbM5iTaf0jvVdmZla3HHwy4=/560x395/filters:quality(80):format(jpg)/cloudfront-us-east-1.images.arcpublishing.com/coindesk/VAEPHCB7QRG5FJ3WWYBEOACDI4.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SATOSHIK>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSHIK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATOSHIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

