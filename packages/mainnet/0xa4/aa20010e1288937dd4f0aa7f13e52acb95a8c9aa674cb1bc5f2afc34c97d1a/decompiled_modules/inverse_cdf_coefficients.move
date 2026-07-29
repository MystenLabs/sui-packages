module 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::inverse_cdf_coefficients {
    public(friend) fun central_den_mags() : vector<u128> {
        vector[1000000000000000000, 6529770225105169200, 12334556167734767000, 4976833894244148100, 41843124728576022000, 40368251986910948000, 1464143571324117500, 16255923057278231000, 4340275740493888500]
    }

    public(friend) fun central_den_negs() : vector<bool> {
        vector[false, true, false, false, true, false, false, true, false]
    }

    public(friend) fun central_num_mags() : vector<u128> {
        vector[83972306, 2506628254154931000, 16367705161149370000, 33543029084694709000, 4664071409401003600, 66749240883508804000, 76683461193510112000, 20089216772437418000, 4626216279451577800]
    }

    public(friend) fun central_num_negs() : vector<bool> {
        vector[false, false, true, false, true, true, false, true, true]
    }

    public(friend) fun central_threshold_raw() : u128 {
        975000000
    }

    public(friend) fun max_z_raw() : u128 {
        6109410205
    }

    public(friend) fun tail_den_mags() : vector<u128> {
        vector[1000000000000000000, 4664193128006789000, 3324846871342176000, 386441302093894930, 4952204793303]
    }

    public(friend) fun tail_den_negs() : vector<bool> {
        vector[false, false, false, false, false]
    }

    public(friend) fun tail_num_mags() : vector<u128> {
        vector[3094339710561733600, 6207376019943557000, 3075018098279669000, 3306509139927573000, 386804656519127650]
    }

    public(friend) fun tail_num_negs() : vector<bool> {
        vector[true, true, false, false, false]
    }

    // decompiled from Move bytecode v7
}

