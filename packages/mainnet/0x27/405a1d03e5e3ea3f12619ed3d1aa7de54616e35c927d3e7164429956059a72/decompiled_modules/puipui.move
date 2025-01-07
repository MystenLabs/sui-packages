module 0x27405a1d03e5e3ea3f12619ed3d1aa7de54616e35c927d3e7164429956059a72::puipui {
    struct PUIPUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUIPUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUIPUI>(arg0, 6, b"PUIPUI", b"PuiPuiOnSui", b"looking for da moon ? let puipui takes you there", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241005_063620_bcfa2917b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUIPUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUIPUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

