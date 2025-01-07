module 0xb941ee972dfa7fd8d6844ca35d64435cdd91eb7bf3b7ead09a3ab1fad89e2385::suifer {
    struct SUIFER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFER>(arg0, 6, b"SUIFER", b"SUIFER Dog", b"suifercoin.com . SUIFER rides the waves of the Sui chain with the grace of a Shiba Inu on a surfboard!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_15_165124_3740df79d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFER>>(v1);
    }

    // decompiled from Move bytecode v6
}

