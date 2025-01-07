module 0xd5c2adab0d07c48a2cc2ccd983f136ae41058bc28a1acb3f87b9a7ab25de3673::medal {
    struct MEDAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEDAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEDAL>(arg0, 9, b"MEDAL", b"MEDAL", b"Medal of Freedom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GgjjaTdXAAAl1PW?format=jpg&name=medium")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEDAL>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEDAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEDAL>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

