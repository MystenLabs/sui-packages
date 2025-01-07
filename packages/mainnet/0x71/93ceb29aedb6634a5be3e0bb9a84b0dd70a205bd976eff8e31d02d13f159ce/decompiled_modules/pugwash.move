module 0x7193ceb29aedb6634a5be3e0bb9a84b0dd70a205bd976eff8e31d02d13f159ce::pugwash {
    struct PUGWASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGWASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGWASH>(arg0, 6, b"PUGWASH", b"Captain Pugwash", b"CAPTAIN PUGWASH sails the Sui seas, combining fun, adventure, and speed. Designed for bold explorers, this token is your guide to new crypto horizons. Whether a seasoned sailor or a newbie, get ready to chart your course with CAPTAIN PUGWASH!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PUGWASH_CIRCLE_LOGO_c233bca866.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGWASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUGWASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

