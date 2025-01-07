module 0xe71e65c043fdcf62af7c0f18793875dd66d2706cb5be5600318f1b322183525::suijin {
    struct SUIJIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJIN>(arg0, 9, b"SUIJIN", b"Suijin", b"$SUIJIN the God of water . https://the-demonic-paradise.fandom.com/wiki/Suijin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FIMG_5264_3278b65bd7.jpeg&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIJIN>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJIN>>(v2, @0x3e5a78284e4680cb2230cc8de33b29ce19b79ec47c36cf28c8b1b2e3ec44e178);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

