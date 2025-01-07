module 0x3b1d32e18eff475c8b53d44c1a7d34857ba91efdfd14d7b91511f1e286305d33::hallosui {
    struct HALLOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALLOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALLOSUI>(arg0, 6, b"HALLOSUI", b"Halloween on Sui", b"The spirit of Halloween has landed on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hallosui_aeec0e3e46.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALLOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALLOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

