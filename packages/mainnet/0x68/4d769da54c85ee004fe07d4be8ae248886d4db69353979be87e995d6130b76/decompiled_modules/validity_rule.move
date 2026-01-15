module 0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::validity_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x2::transfer_policy::TransferPolicy<0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge::Badge>, arg1: &0x2::transfer_policy::TransferPolicyCap<0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge::Badge>) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{dummy_field: false};
        0x2::transfer_policy::add_rule<0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge::Badge, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun prove(arg0: &mut 0x2::transfer_policy::TransferRequest<0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge::Badge>, arg1: &0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge_registry::BadgeRegistry) {
        assert!(0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge_registry::is_tradeable(arg1, 0x2::transfer_policy::item<0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge::Badge>(arg0)), 0);
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge::Badge, Rule>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

