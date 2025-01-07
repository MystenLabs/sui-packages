module 0xc339e714357efebaea3359b74889df2479b913fff92d982a1a62e5a25987187::killmytime {
    struct KILLMYTIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: KILLMYTIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KILLMYTIME>(arg0, 6, b"KMY", b"KILLMYTIME", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/22070968?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KILLMYTIME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KILLMYTIME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

