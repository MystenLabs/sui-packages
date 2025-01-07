module 0x5843e0a92c83edded88f57537ad12cf4ae5e3bca279b8d263124bf38e7ff598::peobif {
    struct PEOBIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEOBIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEOBIF>(arg0, 9, b"PEOBIF", b"Peobif Sui", b"PEOBIF IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/221/201/large/vittor-capa-k.jpg?1727021370")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEOBIF>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEOBIF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEOBIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

