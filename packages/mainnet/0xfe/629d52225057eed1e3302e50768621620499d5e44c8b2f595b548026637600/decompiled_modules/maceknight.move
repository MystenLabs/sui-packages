module 0xfe629d52225057eed1e3302e50768621620499d5e44c8b2f595b548026637600::maceknight {
    struct MACEKNIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MACEKNIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MACEKNIGHT>(arg0, 9, b"maceknight", b"Mace Knight", b"MACEKNIGHT IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/688/122/large/juan-zunino-macknight-2.jpg?1728262046")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MACEKNIGHT>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MACEKNIGHT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MACEKNIGHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

