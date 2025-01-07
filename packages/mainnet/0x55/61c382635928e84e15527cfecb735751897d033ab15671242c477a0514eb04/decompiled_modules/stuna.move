module 0x5561c382635928e84e15527cfecb735751897d033ab15671242c477a0514eb04::stuna {
    struct STUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STUNA>(arg0, 6, b"STUNA", b"SUI TUNA DRIVER", b"Welcome to the Tuna Driver Community, where fun meets futurism on the fast lanes of cryptocurrency! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Yv4_Ci_GOI_400x400_7b6824c17e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

