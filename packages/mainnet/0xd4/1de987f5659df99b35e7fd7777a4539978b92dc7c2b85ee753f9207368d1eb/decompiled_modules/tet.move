module 0xd41de987f5659df99b35e7fd7777a4539978b92dc7c2b85ee753f9207368d1eb::tet {
    struct TET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TET>(arg0, 6, b"TET", b"TEAA", b"AAFADA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750639416544.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

