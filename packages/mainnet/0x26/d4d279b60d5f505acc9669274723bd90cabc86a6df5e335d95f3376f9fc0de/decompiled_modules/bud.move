module 0x26d4d279b60d5f505acc9669274723bd90cabc86a6df5e335d95f3376f9fc0de::bud {
    struct BUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUD>(arg0, 6, b"BUD", b"Holy Nigga Dog", b"I won't eat if I haven't prayed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_Fu_SU_Jh_B41_Cb_Pnc7yh_KAPUAX_Wm_PS_Qqw_KV_Ke_Utzot8_TKE_bfb9180461.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

