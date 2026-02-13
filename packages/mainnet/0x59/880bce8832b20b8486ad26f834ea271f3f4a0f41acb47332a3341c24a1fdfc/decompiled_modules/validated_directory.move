module 0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::validated_directory {
    struct ValidatedCap has drop {
        dummy_field: bool,
    }

    struct ValidatedDirectoryConfig has key {
        id: 0x2::object::UID,
        validator: address,
        min_score: u8,
    }

    public fun create_directory(arg0: address, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ValidatedCap{dummy_field: false};
        0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::directory::create_directory<ValidatedCap>(&v0, arg2);
        let v1 = ValidatedDirectoryConfig{
            id        : 0x2::object::new(arg2),
            validator : arg0,
            min_score : arg1,
        };
        0x2::transfer::share_object<ValidatedDirectoryConfig>(v1);
    }

    public fun delist(arg0: &mut 0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::directory::AgentDirectory<ValidatedCap>, arg1: &0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::identity::AgentIdentity) {
        let v0 = ValidatedCap{dummy_field: false};
        0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::directory::delist<ValidatedCap>(arg0, &v0, arg1);
    }

    public fun list(arg0: &ValidatedDirectoryConfig, arg1: &mut 0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::directory::AgentDirectory<ValidatedCap>, arg2: &0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::identity::AgentIdentity, arg3: &0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::validation::ValidationBoard, arg4: &0x2::tx_context::TxContext) {
        assert_validated(arg0, arg3);
        let v0 = ValidatedCap{dummy_field: false};
        0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::directory::list<ValidatedCap>(arg1, &v0, arg2, arg4);
    }

    public fun update_listing(arg0: &ValidatedDirectoryConfig, arg1: &mut 0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::directory::AgentDirectory<ValidatedCap>, arg2: &0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::identity::AgentIdentity, arg3: &0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::validation::ValidationBoard, arg4: &0x2::tx_context::TxContext) {
        assert_validated(arg0, arg3);
        let v0 = ValidatedCap{dummy_field: false};
        0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::directory::update_listing<ValidatedCap>(arg1, &v0, arg2, arg4);
    }

    fun assert_validated(arg0: &ValidatedDirectoryConfig, arg1: &0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::validation::ValidationBoard) {
        let v0 = 0;
        while (v0 < 0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::validation::request_count(arg1)) {
            let v1 = 0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::validation::get_validation(arg1, v0);
            if (0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::validation::record_validator(v1) == arg0.validator) {
                let v2 = 0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::validation::record_responses(v1);
                let v3 = 0;
                while (v3 < 0x1::vector::length<0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::validation::ValidationResponse>(v2)) {
                    if (0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::validation::response_score(0x1::vector::borrow<0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::validation::ValidationResponse>(v2, v3)) >= arg0.min_score) {
                        return
                    };
                    v3 = v3 + 1;
                };
            };
            v0 = v0 + 1;
        };
        abort 0
    }

    public fun min_score(arg0: &ValidatedDirectoryConfig) : u8 {
        arg0.min_score
    }

    public fun validator(arg0: &ValidatedDirectoryConfig) : address {
        arg0.validator
    }

    // decompiled from Move bytecode v6
}

