module 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::gangsters {
    public(friend) fun validate_available_gangster(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::igangsters::GangsterBaseStats, arg1: 0x1::string::String) {
        assert!(0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::igangsters::is_valid_unit(arg0, arg1), 0);
        assert!(0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::igangsters::has_unit_df(arg0, arg1), 1);
    }

    public(friend) fun validate_turf_recruit_cost(arg0: u128, arg1: u128) {
        assert!(arg0 >= arg1, 2);
    }

    // decompiled from Move bytecode v6
}

