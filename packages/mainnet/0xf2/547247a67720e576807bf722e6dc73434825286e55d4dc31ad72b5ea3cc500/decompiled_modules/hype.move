module 0xf2547247a67720e576807bf722e6dc73434825286e55d4dc31ad72b5ea3cc500::hype {
    struct HYPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPE>(arg0, 9, b"HYPE", b"HYPE", b"HYPE OF WEEK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://previews.123rf.com/images/olejio/olejio1709/olejio170900003/85781330-hype-badge-with-isolated-abstract-cloud-icon.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HYPE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

