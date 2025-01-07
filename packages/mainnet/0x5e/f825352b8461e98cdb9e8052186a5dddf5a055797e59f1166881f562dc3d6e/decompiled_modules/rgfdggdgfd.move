module 0x5ef825352b8461e98cdb9e8052186a5dddf5a055797e59f1166881f562dc3d6e::rgfdggdgfd {
    struct RGFDGGDGFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RGFDGGDGFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RGFDGGDGFD>(arg0, 9, b"RGFDGGDGFD", b"ghfhfhgfg", b"dfgdfgdgdfd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/be0da07d-a42a-4a1e-9678-752819135de0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RGFDGGDGFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RGFDGGDGFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

