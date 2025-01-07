module 0x94f90619e1fa72753140e8f3496d32df805456194601b00a477b9936dd002141::suieal {
    struct SUIEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEAL>(arg0, 6, b"SUIEAL", b"Sui Seal", b"Meet Sui Seal, Gliding through the deep waters of the Sui network, this seal is sleek, swift, and ready to make waves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/umutcklc_imagine_a_cartoon_design_of_blue_leopard_sealmascot_1b6e5efc_e321_457c_8a15_db92626ea4d1_0_d2ea831138.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

