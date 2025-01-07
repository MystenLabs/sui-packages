module 0x94f77aa5ea40da16d3a50a005217e4d6f7d798b842fb01f192dd70ee232b1b3c::hmcch {
    struct HMCCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMCCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMCCH>(arg0, 9, b"HMCCH", b" chkc", b"dhcxv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11ea7ace-02d6-4384-af19-433f7d9b8961.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMCCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HMCCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

