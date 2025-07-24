module 0xfb4a602b0b5424f93e84c4255d608ff65fe21558f5aa4ad3af37ad3357f50db::sab {
    struct SAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAB>(arg0, 6, b"SAB", b"SuiAbout", b"SuiAbout: Where memes meet blockchain! Building the most fun community on Sui. Ready to become a SuiBuddy?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/suiabout_removebg_preview_f00778db50.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

