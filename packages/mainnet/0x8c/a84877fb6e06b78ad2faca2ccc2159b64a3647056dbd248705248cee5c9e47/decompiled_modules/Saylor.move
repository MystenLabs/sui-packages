module 0x8ca84877fb6e06b78ad2faca2ccc2159b64a3647056dbd248705248cee5c9e47::Saylor {
    struct SAYLOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAYLOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAYLOR>(arg0, 9, b"SAYLOR", b"Saylor", b"orange man marathon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gz_YHc2XYAAoKcX?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAYLOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAYLOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

