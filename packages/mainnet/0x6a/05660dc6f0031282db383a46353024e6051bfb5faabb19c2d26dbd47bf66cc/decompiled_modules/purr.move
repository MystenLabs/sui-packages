module 0x6a05660dc6f0031282db383a46353024e6051bfb5faabb19c2d26dbd47bf66cc::purr {
    struct PURR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURR>(arg0, 6, b"PURR", b"PURR CAT", b"PURR PURR PURR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Xt_KV_48_WMA_An_Z1n_28e8afdfd3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PURR>>(v1);
    }

    // decompiled from Move bytecode v6
}

