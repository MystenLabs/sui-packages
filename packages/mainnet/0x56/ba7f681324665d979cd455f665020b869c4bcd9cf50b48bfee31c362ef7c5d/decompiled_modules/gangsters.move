module 0x56ba7f681324665d979cd455f665020b869c4bcd9cf50b48bfee31c362ef7c5d::gangsters {
    public(friend) fun validate_available_gangster(arg0: &0x56ba7f681324665d979cd455f665020b869c4bcd9cf50b48bfee31c362ef7c5d::igangsters::GangsterBaseStats, arg1: 0x1::string::String) {
        assert!(0x56ba7f681324665d979cd455f665020b869c4bcd9cf50b48bfee31c362ef7c5d::igangsters::is_valid_unit(arg0, arg1), 0);
        assert!(0x56ba7f681324665d979cd455f665020b869c4bcd9cf50b48bfee31c362ef7c5d::igangsters::has_unit_df(arg0, arg1), 1);
    }

    public(friend) fun validate_turf_recruit_cost(arg0: u128, arg1: u128) {
        assert!(arg0 >= arg1, 2);
    }

    // decompiled from Move bytecode v6
}

