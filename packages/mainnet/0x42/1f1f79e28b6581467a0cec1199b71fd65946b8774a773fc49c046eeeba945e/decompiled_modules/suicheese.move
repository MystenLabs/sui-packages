module 0x421f1f79e28b6581467a0cec1199b71fd65946b8774a773fc49c046eeeba945e::suicheese {
    struct SUICHEESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHEESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHEESE>(arg0, 6, b"SUICHEESE", b"SUIsse Cheese", b"Time for some SUIsse Cheese", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5803146896397682193_6b59066976.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHEESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHEESE>>(v1);
    }

    // decompiled from Move bytecode v6
}

