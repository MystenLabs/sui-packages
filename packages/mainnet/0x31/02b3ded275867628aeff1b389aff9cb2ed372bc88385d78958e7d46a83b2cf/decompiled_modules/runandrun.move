module 0x3102b3ded275867628aeff1b389aff9cb2ed372bc88385d78958e7d46a83b2cf::runandrun {
    struct RUNANDRUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUNANDRUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUNANDRUN>(arg0, 6, b"RunandRun", b"bakunkem", b"just for me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tanssi_Network_is_a_blockchain_infrastructure_protocol_enabling_the_deployment_of_customized_appchains_in_minutes_no_code_required_Built_on_Substrate_and_integrated_with_Symbiotica_s_ETH_restakin_1d812851c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUNANDRUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUNANDRUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

