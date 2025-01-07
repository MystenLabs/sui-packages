module 0x90101d1126aad4e539bc5a8d78a76001b91693df2343dbc5e3cf4c4a0f38ab22::fucky {
    struct FUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKY>(arg0, 6, b"FUCKY", b"Fucky On Sui", b"Genius, feathered billionaire, bird-playboy, philanthropist, and simply a historical figure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vj4_wd_XC_400x400_47186290c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

