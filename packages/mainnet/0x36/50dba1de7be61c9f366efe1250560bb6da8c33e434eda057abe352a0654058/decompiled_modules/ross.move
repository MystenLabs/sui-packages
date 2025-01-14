module 0x3650dba1de7be61c9f366efe1250560bb6da8c33e434eda057abe352a0654058::ross {
    struct ROSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSS>(arg0, 6, b"ROSS", b"Ross on Sui", b"Ross Ulbricht, the creator of Silk Road, has been imprisoned since 2013 for non-violent offenses as a first-time offender. Silk Road was an anonymous e-commerce site where users could trade various goods, including small amounts of cannabis, though harmful items were prohibited. While Ulbricht wasn't convicted of selling illegal items, he was held responsible for what others sold on the platform. He has served 11 years of his sentence, and if elected, Donald Trump has vowed to commute Ulbrichts sentence to time served and bring him home.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rossbars_05921e4d20.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

