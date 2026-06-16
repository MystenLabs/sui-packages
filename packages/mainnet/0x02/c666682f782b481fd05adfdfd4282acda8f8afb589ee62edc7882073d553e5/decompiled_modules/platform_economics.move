module 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::platform_economics {
    public fun tip_publication(arg0: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::GlobalConfig, arg1: &mut 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::Publication, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::assert_version(arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 702);
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::add_tip_balance(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::inkray_events::emit_publication_tipped(0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::get_publication_object_id(arg1), 0x2::tx_context::sender(arg3), v0);
    }

    public fun withdraw_all_tips(arg0: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::GlobalConfig, arg1: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::PublicationOwnerCap, arg2: &mut 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::Publication, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::assert_version(arg0);
        assert!(0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::verify_owner_cap(arg1, arg2), 701);
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::withdraw_tip_balance(arg2, 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::get_tip_balance(arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

