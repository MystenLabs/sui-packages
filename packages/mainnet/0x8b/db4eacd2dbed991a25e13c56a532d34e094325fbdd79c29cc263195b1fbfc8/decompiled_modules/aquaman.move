module 0x8bdb4eacd2dbed991a25e13c56a532d34e094325fbdd79c29cc263195b1fbfc8::aquaman {
    struct AQUAMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUAMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUAMAN>(arg0, 6, b"AQUAMAN", b"AQUAMAN CTO", b"AQUAMAN CTO, lets push it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B_Fjyv_gm_400x400_4797eb8dda.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUAMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUAMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

