module 0x5d61b2f901fd89796c25684efdc054f0574946c4ec21a3d8c5b5ec6bf6655a66::smoke {
    struct SMOKE has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"smoke", b"Smokey The Bear", b"Literally just Smokey the bear. Protect the forest, make some money. No TG no X. Yall wanna make one go for it. Dev out. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FIMG_2665_0ff05a0034.jpeg&w=256&q=75")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: SMOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SMOKE>(arg0, arg1);
        0x2::coin::mint_and_transfer<SMOKE>(&mut v0, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOKE>>(v0, @0xcafe);
    }

    // decompiled from Move bytecode v6
}

