module 0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::fee_router {
    struct BucketSettledEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        bucket: u8,
        amount: u64,
        destination_id: 0x2::object::ID,
    }

    public fun settle_vesca<T0>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::Version, arg2: &mut 0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::revenue_share::RevenueVault, arg3: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::VeScaBindingRegistry) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::assert_version(arg0);
        0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::version_check(arg1);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::assert_revenue_destination(arg0, 0x2::object::id<0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::revenue_share::RevenueVault>(arg2), 0x2::object::id<0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster::VeScaBindingRegistry>(arg3));
        let v0 = 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::take_vesca_bucket<T0>(arg0, 0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::revenue_share::bucket_cap(arg2));
        let v1 = 0x2::balance::value<T0>(&v0);
        assert!(v1 > 0, 2401);
        let v2 = 0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::revenue_share::deposit<T0>(arg0, arg1, arg2, arg3, v0);
        let v3 = v1 - 0x2::balance::value<T0>(&v2);
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::return_vesca_bucket<T0>(arg0, 0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::revenue_share::bucket_cap(arg2), v2);
        if (v3 > 0) {
            let v4 = BucketSettledEvent{
                token          : 0x1::type_name::with_defining_ids<T0>(),
                bucket         : 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::bucket_vesca(),
                amount         : v3,
                destination_id : 0x2::object::id<0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::revenue_share::RevenueVault>(arg2),
            };
            0x2::event::emit<BucketSettledEvent>(v4);
        };
    }

    // decompiled from Move bytecode v7
}

