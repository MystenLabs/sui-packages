module 0x8042b21d5c538add66cebf2de9bc817b19e92e9f8e10a33c1e13c484b802cf86::bento {
    struct BENTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENTO>(arg0, 9, b"BENTO", b"Chico Bento Boy", b"BENTO IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/896/935/large/sergiy-kovpak-2.jpg?1728842250")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BENTO>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENTO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

