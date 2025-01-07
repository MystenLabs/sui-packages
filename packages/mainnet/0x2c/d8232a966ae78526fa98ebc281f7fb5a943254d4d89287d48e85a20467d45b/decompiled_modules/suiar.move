module 0x2cd8232a966ae78526fa98ebc281f7fb5a943254d4d89287d48e85a20467d45b::suiar {
    struct SUIAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAR>(arg0, 6, b"SUIAR", b"ARMY SUI", b"Hello Sui memeeeeeee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2023_05_21_08_47_54_12e834fda2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

