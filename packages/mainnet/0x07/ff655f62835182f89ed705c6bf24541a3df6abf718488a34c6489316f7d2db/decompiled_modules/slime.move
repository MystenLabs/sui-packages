module 0x7ff655f62835182f89ed705c6bf24541a3df6abf718488a34c6489316f7d2db::slime {
    struct SLIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIME>(arg0, 6, b"SLIME", b"SLIME SUI", b"SLIME is BLUE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_50426f4fba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

