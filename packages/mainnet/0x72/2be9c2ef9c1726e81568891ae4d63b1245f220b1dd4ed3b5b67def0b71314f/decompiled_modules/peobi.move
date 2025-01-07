module 0x722be9c2ef9c1726e81568891ae4d63b1245f220b1dd4ed3b5b67def0b71314f::peobi {
    struct PEOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEOBI>(arg0, 9, b"PEOBI", b"Blue Warrior Peobi", b"PEOBI IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/079/813/655/large/kua-a20.jpg?1725898727")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEOBI>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEOBI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEOBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

