module 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::gangsters {
    public(friend) fun validate_available_gangster(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::GangsterBaseStats, arg1: 0x1::string::String) {
        assert!(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::is_valid_unit(arg0, arg1), 0);
        assert!(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::has_unit_df(arg0, arg1), 1);
    }

    public(friend) fun validate_turf_recruit_cost(arg0: u128, arg1: u128) {
        assert!(arg0 >= arg1, 2);
    }

    // decompiled from Move bytecode v6
}

