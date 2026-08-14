module 0xfcf790e8595b5b225c9488fa7566c97237d81fbfd7816db1a972217819918d45::price_feed_storage {
    public fun force_remove_price_feed<T0>(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<0xfcf790e8595b5b225c9488fa7566c97237d81fbfd7816db1a972217819918d45::source::DEV>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::PACKAGE, T0>, arg2: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg3: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage) {
        0xfcf790e8595b5b225c9488fa7566c97237d81fbfd7816db1a972217819918d45::source::assert_version(arg0);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::force_remove_price_feed<T0>(arg3, arg1, arg2, 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::source_id<0xfcf790e8595b5b225c9488fa7566c97237d81fbfd7816db1a972217819918d45::source::DEV>(arg0));
    }

    public fun new_price_feed<T0, T1>(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<0xfcf790e8595b5b225c9488fa7566c97237d81fbfd7816db1a972217819918d45::source::DEV>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::VENDOR<T0>, T1>, arg2: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg3: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg4: u128, arg5: u64, arg6: u64) {
        0xfcf790e8595b5b225c9488fa7566c97237d81fbfd7816db1a972217819918d45::source::assert_version(arg0);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::new_price_feed<T0, T1, 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<0xfcf790e8595b5b225c9488fa7566c97237d81fbfd7816db1a972217819918d45::source::DEV>>(arg3, arg1, arg2, 0xfcf790e8595b5b225c9488fa7566c97237d81fbfd7816db1a972217819918d45::source::source_cap(arg0), arg0, arg4, arg5, arg6);
    }

    public fun remove_price_feed<T0>(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<0xfcf790e8595b5b225c9488fa7566c97237d81fbfd7816db1a972217819918d45::source::DEV>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::VENDOR<T0>, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg3: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage) {
        0xfcf790e8595b5b225c9488fa7566c97237d81fbfd7816db1a972217819918d45::source::assert_version(arg0);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::remove_price_feed<T0>(arg3, arg1, arg2, 0xfcf790e8595b5b225c9488fa7566c97237d81fbfd7816db1a972217819918d45::source::source_cap(arg0));
    }

    public fun set_twap_period_ms<T0, T1>(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<0xfcf790e8595b5b225c9488fa7566c97237d81fbfd7816db1a972217819918d45::source::DEV>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::VENDOR<T0>, T1>, arg2: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg3: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg4: u64) {
        0xfcf790e8595b5b225c9488fa7566c97237d81fbfd7816db1a972217819918d45::source::assert_version(arg0);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::set_twap_period_ms<T0, T1>(arg3, arg1, arg2, 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::source_id<0xfcf790e8595b5b225c9488fa7566c97237d81fbfd7816db1a972217819918d45::source::DEV>(arg0), arg4);
    }

    public fun update_price_feed<T0, T1>(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<0xfcf790e8595b5b225c9488fa7566c97237d81fbfd7816db1a972217819918d45::source::DEV>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::VENDOR<T0>, T1>, arg2: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg3: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg4: u128, arg5: u64) {
        0xfcf790e8595b5b225c9488fa7566c97237d81fbfd7816db1a972217819918d45::source::assert_version(arg0);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::assert_package_version(arg2);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::assert_is_admin_or_assistant<T1>();
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::assert_vendor_authority_cap_is_valid<T0, T1>(arg2, arg1);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::assert_has_vendor_authorization<T0>(arg3);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::update_price_feed<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<0xfcf790e8595b5b225c9488fa7566c97237d81fbfd7816db1a972217819918d45::source::DEV>>(arg3, arg2, 0xfcf790e8595b5b225c9488fa7566c97237d81fbfd7816db1a972217819918d45::source::source_cap(arg0), arg0, arg4, arg5);
    }

    // decompiled from Move bytecode v7
}

