module 0x5323517eff4aecde18ae6a818277d40eaad4e95bd9d4770e1f6ec89a107806d8::satoshi {
    struct SATOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOSHI>(arg0, 9, b"SATOSHI", b"SATOSHI", b"Satoshi one of the one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.coindesk.com/resizer/x9N8qbM5iTaf0jvVdmZla3HHwy4=/560x395/filters:quality(80):format(jpg)/cloudfront-us-east-1.images.arcpublishing.com/coindesk/VAEPHCB7QRG5FJ3WWYBEOACDI4.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SATOSHI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSHI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

