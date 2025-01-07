module 0x76d6458e699d6a9afa25d97020d67b79a20a5fc0c85009edccc50d8629aef523::suimap {
    struct SUIMAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAP>(arg0, 6, b"SuiMAP", b"SuiMap", b"suimaps give you the power of digital ownership over a plot of Sui and freedom to build unconstrained in the context of a consensus and community-driven project.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_N_D_D_D_D_D_N_D_D_D_2024_09_25_D_22_00_43_38f0888422.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

