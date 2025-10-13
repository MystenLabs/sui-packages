module 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_asset {
    public(friend) fun init_state<T0: drop, T1: store + key>(arg0: T0, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 0);
        let v0 = 0x2::package::claim<T0>(arg0, arg4);
        let v1 = 0x2::display::new_with_fields<T1>(&v0, arg1, arg2, arg4);
        0x2::display::update_version<T1>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<T1>(&v0, arg4);
        let v4 = v3;
        let v5 = v2;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<T1>(&mut v5, &v4, arg3, 0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<T1>(&mut v5, &v4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::add<T1>(&mut v5, &v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<T1>>(v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, @0x8233bf6971d0819edf3684b276bb03d4b7c005931909206564b71855d37145a1);
        0x2::transfer::public_transfer<0x2::display::Display<T1>>(v1, @0x8233bf6971d0819edf3684b276bb03d4b7c005931909206564b71855d37145a1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<T1>>(v4, @0x8233bf6971d0819edf3684b276bb03d4b7c005931909206564b71855d37145a1);
    }

    // decompiled from Move bytecode v6
}

