module 0xc46fbc2022f045f478d0cb0ece80ad6cefce7c675af67db3041cbb0115f5cb68::anubis {
    struct ANUBIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANUBIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANUBIS>(arg0, 9, b"ANUBIS", b"Anubis", b"ANUBIS IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/854/242/large/sergio-khazov-serghaz-cape.jpg?1728685663")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANUBIS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANUBIS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANUBIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

