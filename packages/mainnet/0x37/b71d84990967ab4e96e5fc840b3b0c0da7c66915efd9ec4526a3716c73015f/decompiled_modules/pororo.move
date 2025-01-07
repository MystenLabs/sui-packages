module 0x37b71d84990967ab4e96e5fc840b3b0c0da7c66915efd9ec4526a3716c73015f::pororo {
    struct PORORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORORO>(arg0, 6, b"PORORO", b"PororoSUI", b"Pororo appeared in Sui. Gather all your friends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_e_e_e_i_removebg_preview_bc1db82747.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORORO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PORORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

