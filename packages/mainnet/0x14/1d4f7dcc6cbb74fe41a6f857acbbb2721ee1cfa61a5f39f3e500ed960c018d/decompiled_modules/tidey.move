module 0x141d4f7dcc6cbb74fe41a6f857acbbb2721ee1cfa61a5f39f3e500ed960c018d::tidey {
    struct TIDEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIDEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIDEY>(arg0, 6, b"Tidey", b"TIDEY", b"$TIDEY is a legendary underwater creature that protects the entire ecosystem in the SUI world. $TIDEY can transform into anything, and like a ghost, he can also be invisible. The tidal waves that are pumped indicate his presence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tidey_8c6a3db1d0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIDEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIDEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

