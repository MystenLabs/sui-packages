module 0x6546f28d228dc55ca5057292db8e9b5b2c0f456691eb546e8c24472b67bf415e::grok {
    struct GROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROK>(arg0, 6, b"GROK", b"GROKSUI", x"4120736c696768746c79206f6265736520707572706c6520667269656e64200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_NFJ_1_Urs_400x400_f9cbbeda92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

