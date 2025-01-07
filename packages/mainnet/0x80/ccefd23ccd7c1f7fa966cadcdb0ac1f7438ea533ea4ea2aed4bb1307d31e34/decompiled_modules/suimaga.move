module 0x80ccefd23ccd7c1f7fa966cadcdb0ac1f7438ea533ea4ea2aed4bb1307d31e34::suimaga {
    struct SUIMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAGA>(arg0, 6, b"SUIMAGA", b"SUI MAGA", b"make america great again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731040377770.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMAGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

