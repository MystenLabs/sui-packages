module 0x9efe7cacdf72ffcff2bffa39c3ad01ea8900a687eec7a69d0dc52be805519397::swomen {
    struct SWOMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOMEN>(arg0, 6, b"SWOMEN", b"Suiwomen", b"Who run the world? ... Women! $SWOMEN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_16_20_59_56_04f04aa14a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWOMEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

