module 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service_preregister {
    struct Feature has drop {
        dummy_field: bool,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        is_open_claim_refund: bool,
    }

    public(friend) fun add(arg0: &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                   : 0x2::object::new(arg1),
            is_open_claim_refund : false,
        };
        0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::add_feature<Feature, Config>(arg0, v0);
    }

    public(friend) fun is_use_preregister(arg0: &0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service) : bool {
        let v0 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_key_by_struct<Feature>();
        0x2::vec_set::contains<0x1::string::String>(0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::features(arg0), &v0)
    }

    public(friend) fun remove(arg0: &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service) {
        let Config {
            id                   : v0,
            is_open_claim_refund : _,
        } = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::remove_feature<Feature, Config>(arg0);
        0x2::object::delete(v0);
    }

    public(friend) fun set_is_open_claim_refund(arg0: &mut 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service, arg1: bool) {
        let v0 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_key_by_struct<Feature>();
        if (0x2::vec_set::contains<0x1::string::String>(0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::features(arg0), &v0)) {
            0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::get_feature_mut<Feature, Config>(arg0).is_open_claim_refund = arg1;
        };
    }

    public(friend) fun validate_claim_refund(arg0: &0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service) {
        let v0 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_key_by_struct<Feature>();
        assert!(0x2::vec_set::contains<0x1::string::String>(0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::features(arg0), &v0), 900);
        assert!(0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::get_feature<Feature, Config>(arg0).is_open_claim_refund, 901);
    }

    public(friend) fun validate_purchase(arg0: &0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::Service, arg1: u64, arg2: u64) {
        let v0 = 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils::get_key_by_struct<Feature>();
        if (0x2::vec_set::contains<0x1::string::String>(0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::features(arg0), &v0)) {
            assert!(!0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::service::get_feature<Feature, Config>(arg0).is_open_claim_refund, 901);
        } else {
            assert!(arg1 <= arg2, 908);
        };
    }

    // decompiled from Move bytecode v6
}

