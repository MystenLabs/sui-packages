module 0x82c58782e938c37910934268fa9a0e5a23c8509fc55c6da38c796177cd8eb674::suiw {
    struct SUIW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIW>(arg0, 6, b"SUIW", b"SuiWhale", b"SuiWhale is a meme coin to attract whale to the sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000218816_eb05f98c03.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIW>>(v1);
    }

    // decompiled from Move bytecode v6
}

