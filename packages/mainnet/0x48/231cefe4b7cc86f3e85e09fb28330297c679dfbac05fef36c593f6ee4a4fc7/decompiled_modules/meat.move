module 0x48231cefe4b7cc86f3e85e09fb28330297c679dfbac05fef36c593f6ee4a4fc7::meat {
    struct MEAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEAT>(arg0, 6, b"Meat", b"Meat the President", b"Nice to meat you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/food_trump_0_2430608244_1_3e8b05dce4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

