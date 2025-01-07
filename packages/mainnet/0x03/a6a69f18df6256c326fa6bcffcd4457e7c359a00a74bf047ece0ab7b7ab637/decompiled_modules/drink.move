module 0x3a6a69f18df6256c326fa6bcffcd4457e7c359a00a74bf047ece0ab7b7ab637::drink {
    struct DRINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRINK>(arg0, 6, b"DRINK", b"DRINKIES", b"JUDT TRY IT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a3_V7k_Zq_E_400x400_4cbb9de0f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

