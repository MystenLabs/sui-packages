module 0x6811a74510fb7b4b9eb507be1d3f3a9e5f85818b3bdf9434dac5c6bbfdd35d9d::vodka {
    struct VODKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VODKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VODKA>(arg0, 9, b"VODKA", b"RUSSIAN", b"If you want to feel the taste of Russian vodka, then this is for you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lexica.art/prompt/a5a46602-951e-43ce-afad-c81229440825")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VODKA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VODKA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VODKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

