module 0xd825aa404533f9efe2f9dd1ba1662cc82917997624aadfaaf0080ab36dc2159::suimmy {
    struct SUIMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMMY>(arg0, 6, b"SUIMMY", b"SUIMMY on SUI", b"Suimmy dive deep into the sui, where every swim unveils a new heights!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/95132b98_5601_4f49_b0d8_f2e2224ed4e6_d86dded212.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

