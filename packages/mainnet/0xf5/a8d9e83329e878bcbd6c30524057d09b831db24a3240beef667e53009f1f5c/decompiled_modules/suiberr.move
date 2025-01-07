module 0xf5a8d9e83329e878bcbd6c30524057d09b831db24a3240beef667e53009f1f5c::suiberr {
    struct SUIBERR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBERR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBERR>(arg0, 6, b"Suiberr", b"$SUIBERRY", b"No sweet promises needed 'cause $SUIBERR is already sweet! No devs, just a solid crew hangin' here!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Desain_tanpa_judul_6_6cc7d16502.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBERR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBERR>>(v1);
    }

    // decompiled from Move bytecode v6
}

