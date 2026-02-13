module 0xc081cad7d4f65942d3693b720d8ba7c58170f3fd82584af96bc562aca2c2619d::validated_directory {
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
        0xc081cad7d4f65942d3693b720d8ba7c58170f3fd82584af96bc562aca2c2619d::directory::create_directory<ValidatedCap>(&v0, arg2);
        let v1 = ValidatedDirectoryConfig{
            id        : 0x2::object::new(arg2),
            validator : arg0,
            min_score : arg1,
        };
        0x2::transfer::share_object<ValidatedDirectoryConfig>(v1);
    }

    public fun delist(arg0: &mut 0xc081cad7d4f65942d3693b720d8ba7c58170f3fd82584af96bc562aca2c2619d::directory::AgentDirectory<ValidatedCap>, arg1: &0xc081cad7d4f65942d3693b720d8ba7c58170f3fd82584af96bc562aca2c2619d::identity::AgentIdentity) {
        let v0 = ValidatedCap{dummy_field: false};
        0xc081cad7d4f65942d3693b720d8ba7c58170f3fd82584af96bc562aca2c2619d::directory::delist<ValidatedCap>(arg0, &v0, arg1);
    }

    public fun list(arg0: &ValidatedDirectoryConfig, arg1: &mut 0xc081cad7d4f65942d3693b720d8ba7c58170f3fd82584af96bc562aca2c2619d::directory::AgentDirectory<ValidatedCap>, arg2: &0xc081cad7d4f65942d3693b720d8ba7c58170f3fd82584af96bc562aca2c2619d::identity::AgentIdentity, arg3: &0xc081cad7d4f65942d3693b720d8ba7c58170f3fd82584af96bc562aca2c2619d::validation::ValidationBoard, arg4: &0x2::tx_context::TxContext) {
        assert_validated(arg0, arg3);
        let v0 = ValidatedCap{dummy_field: false};
        0xc081cad7d4f65942d3693b720d8ba7c58170f3fd82584af96bc562aca2c2619d::directory::list<ValidatedCap>(arg1, &v0, arg2, arg4);
    }

    public fun update_listing(arg0: &ValidatedDirectoryConfig, arg1: &mut 0xc081cad7d4f65942d3693b720d8ba7c58170f3fd82584af96bc562aca2c2619d::directory::AgentDirectory<ValidatedCap>, arg2: &0xc081cad7d4f65942d3693b720d8ba7c58170f3fd82584af96bc562aca2c2619d::identity::AgentIdentity, arg3: &0xc081cad7d4f65942d3693b720d8ba7c58170f3fd82584af96bc562aca2c2619d::validation::ValidationBoard, arg4: &0x2::tx_context::TxContext) {
        assert_validated(arg0, arg3);
        let v0 = ValidatedCap{dummy_field: false};
        0xc081cad7d4f65942d3693b720d8ba7c58170f3fd82584af96bc562aca2c2619d::directory::update_listing<ValidatedCap>(arg1, &v0, arg2, arg4);
    }

    fun assert_validated(arg0: &ValidatedDirectoryConfig, arg1: &0xc081cad7d4f65942d3693b720d8ba7c58170f3fd82584af96bc562aca2c2619d::validation::ValidationBoard) {
        let v0 = 0;
        while (v0 < 0xc081cad7d4f65942d3693b720d8ba7c58170f3fd82584af96bc562aca2c2619d::validation::request_count(arg1)) {
            let v1 = 0xc081cad7d4f65942d3693b720d8ba7c58170f3fd82584af96bc562aca2c2619d::validation::get_validation(arg1, v0);
            if (0xc081cad7d4f65942d3693b720d8ba7c58170f3fd82584af96bc562aca2c2619d::validation::record_validator(v1) == arg0.validator) {
                let v2 = 0xc081cad7d4f65942d3693b720d8ba7c58170f3fd82584af96bc562aca2c2619d::validation::record_responses(v1);
                let v3 = 0;
                while (v3 < 0x1::vector::length<0xc081cad7d4f65942d3693b720d8ba7c58170f3fd82584af96bc562aca2c2619d::validation::ValidationResponse>(v2)) {
                    if (0xc081cad7d4f65942d3693b720d8ba7c58170f3fd82584af96bc562aca2c2619d::validation::response_score(0x1::vector::borrow<0xc081cad7d4f65942d3693b720d8ba7c58170f3fd82584af96bc562aca2c2619d::validation::ValidationResponse>(v2, v3)) >= arg0.min_score) {
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

