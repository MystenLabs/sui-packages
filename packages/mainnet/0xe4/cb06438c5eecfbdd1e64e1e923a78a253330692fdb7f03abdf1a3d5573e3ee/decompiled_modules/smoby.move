module 0xe4cb06438c5eecfbdd1e64e1e923a78a253330692fdb7f03abdf1a3d5573e3ee::smoby {
    struct SMOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOBY>(arg0, 6, b"SMOBY", b"Sui Moby", b"Meet MOBY The Whale, the ultimate symbol of strength and stability on the Sui Chain. Just like a whale in the ocean, MOBY moves with power, guiding traders toward big opportunities in the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_Dz_D_g_Fp_400x400_dede42127c_301c0e257b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

