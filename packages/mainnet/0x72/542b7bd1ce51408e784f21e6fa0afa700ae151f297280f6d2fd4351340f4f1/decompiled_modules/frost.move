module 0x72542b7bd1ce51408e784f21e6fa0afa700ae151f297280f6d2fd4351340f4f1::frost {
    struct FROST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROST>(arg0, 9, b"FROST", b"FROST", b"Majestic hype", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ytimg.com/vi/YZTwFJqKGRg/maxresdefault.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FROST>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROST>>(v1);
    }

    // decompiled from Move bytecode v6
}

