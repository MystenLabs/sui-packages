module 0x8484c24035ba8df1b8661a2ba4da80388c562d8cdcb726b45e8cb8ee96f01603::sakura {
    struct SAKURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAKURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAKURA>(arg0, 6, b"Sakura", b"Sakura TOKEN", b"Sakura ()  Cherry blossom, representing beauty and renewal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Yl9_Ylt_d_400x400_8e5d9bda43.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAKURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAKURA>>(v1);
    }

    // decompiled from Move bytecode v6
}

