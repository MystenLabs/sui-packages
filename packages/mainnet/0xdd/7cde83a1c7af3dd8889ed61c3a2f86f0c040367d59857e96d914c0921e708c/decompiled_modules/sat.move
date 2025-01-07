module 0xdd7cde83a1c7af3dd8889ed61c3a2f86f0c040367d59857e96d914c0921e708c::sat {
    struct SAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAT>(arg0, 9, b"SAT", b"Satoshi", b"Satoshi Nakamoto is the pseudonym of the person who created Bitcoin and wrote its foundational paper in 2008. Their true identity remains unknown.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.coindesk.com/resizer/x9N8qbM5iTaf0jvVdmZla3HHwy4=/560x395/filters:quality(80):format(jpg)/cloudfront-us-east-1.images.arcpublishing.com/coindesk/VAEPHCB7QRG5FJ3WWYBEOACDI4.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

