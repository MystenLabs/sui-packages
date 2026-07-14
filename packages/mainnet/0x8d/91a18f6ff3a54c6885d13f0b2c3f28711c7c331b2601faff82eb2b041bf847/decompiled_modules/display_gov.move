module 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::display_gov {
    struct DisplayGuard has key {
        id: 0x2::object::UID,
        display: 0x2::display::Display<0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::GoldNFT>,
    }

    public fun execute_set_display_field(arg0: &0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::GovernanceConfig, arg1: &mut DisplayGuard, arg2: &mut 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::Proposal, arg3: &0x2::clock::Clock) {
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_version(arg0);
        let (v0, v1) = 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::display_field_params(arg2);
        let v2 = v0;
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::consume(arg0, arg2, arg3);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_display_key_allowed(&v2);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::events::display_field_set(v2, v1);
        0x2::display::edit<0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::GoldNFT>(&mut arg1.display, v2, v1);
        0x2::display::update_version<0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::GoldNFT>(&mut arg1.display);
    }

    public fun install(arg0: 0x2::display::Display<0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::GoldNFT>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DisplayGuard{
            id      : 0x2::object::new(arg1),
            display : arg0,
        };
        0x2::transfer::share_object<DisplayGuard>(v0);
    }

    // decompiled from Move bytecode v7
}

