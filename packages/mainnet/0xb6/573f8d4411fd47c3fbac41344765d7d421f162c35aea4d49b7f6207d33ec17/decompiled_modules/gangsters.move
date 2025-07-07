module 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::gangsters {
    public(friend) fun validate_available_gangster(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::GangsterBaseStats, arg1: 0x1::string::String) {
        assert!(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::is_valid_unit(arg0, arg1), 1);
        assert!(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::has_unit_df(arg0, arg1), 2);
    }

    public(friend) fun validate_turf_recruit_cost(arg0: u128, arg1: u128) {
        assert!(arg0 >= arg1, 3);
    }

    // decompiled from Move bytecode v6
}

