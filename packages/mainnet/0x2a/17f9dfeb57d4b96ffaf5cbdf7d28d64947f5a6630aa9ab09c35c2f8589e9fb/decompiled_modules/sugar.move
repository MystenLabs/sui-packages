module 0x2a17f9dfeb57d4b96ffaf5cbdf7d28d64947f5a6630aa9ab09c35c2f8589e9fb::sugar {
    struct SUGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGAR>(arg0, 6, b"SugaR", b"Sui SugaR", b"Hottest slav drinking ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/57f2_Dc_Zi_400x400_738e89cbaa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUGAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

