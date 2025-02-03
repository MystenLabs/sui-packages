module 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::service_refund {
    struct Feature has drop {
        dummy_field: bool,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        start_refund_time: u64,
        refund_range_time: u64,
        arr_claimed_address: 0x2::vec_set::VecSet<address>,
    }

    public(friend) fun add(arg0: &mut 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::service::Service, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                  : 0x2::object::new(arg3),
            start_refund_time   : arg1,
            refund_range_time   : arg2,
            arr_claimed_address : 0x2::vec_set::empty<address>(),
        };
        0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::service::add_feature<Feature, Config>(arg0, v0);
    }

    public(friend) fun check_valid_refund(arg0: &0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::service::Service, arg1: &0x2::clock::Clock) {
        let v0 = 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::utils::get_key_by_struct<Feature>();
        assert!(0x2::vec_set::contains<0x1::string::String>(0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::service::features(arg0), &v0), 1302);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::service::get_feature<Feature, Config>(arg0);
        assert!(v1 >= v2.start_refund_time, 1300);
        assert!(v1 <= v2.start_refund_time + v2.refund_range_time, 1301);
    }

    public(friend) fun insert_refund_address(arg0: &mut 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::service::Service, arg1: address) {
        let v0 = 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::service::get_feature_mut<Feature, Config>(arg0);
        if (!0x2::vec_set::contains<address>(&v0.arr_claimed_address, &arg1)) {
            0x2::vec_set::insert<address>(&mut v0.arr_claimed_address, arg1);
        };
    }

    public(friend) fun remove(arg0: &mut 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::service::Service) {
        let Config {
            id                  : v0,
            start_refund_time   : _,
            refund_range_time   : _,
            arr_claimed_address : _,
        } = 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::service::remove_feature<Feature, Config>(arg0);
        0x2::object::delete(v0);
    }

    public(friend) fun set_refund_range_time(arg0: &mut 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::service::Service, arg1: u64) {
        0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::service::get_feature_mut<Feature, Config>(arg0).refund_range_time = arg1;
    }

    public(friend) fun set_start_refund_time(arg0: &mut 0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::service::Service, arg1: u64) {
        0x8c51ab7346994589f4f50e71c81e5a2868eb6d9a1033f41afb58ed52dcec43dc::service::get_feature_mut<Feature, Config>(arg0).start_refund_time = arg1;
    }

    // decompiled from Move bytecode v6
}

