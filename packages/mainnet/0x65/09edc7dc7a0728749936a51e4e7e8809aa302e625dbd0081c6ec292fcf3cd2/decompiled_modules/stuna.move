module 0x6509edc7dc7a0728749936a51e4e7e8809aa302e625dbd0081c6ec292fcf3cd2::stuna {
    struct STUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STUNA>(arg0, 6, b"STUNA", b"Sui Tuna Driver", b"Welcome to the $Tuna Driver Community, where fun meets futurism on the fast lanes of cryptocurrency! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Yv4_Ci_GOI_400x400_dc5d9648b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

