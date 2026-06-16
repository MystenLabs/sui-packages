module 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication_subscription {
    struct PublicationSubscription has key {
        id: 0x2::object::UID,
        publication_id: 0x2::object::ID,
        subscriber: address,
        expires_at: u64,
        created_at: u64,
    }

    public fun extend_subscription(arg0: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::GlobalConfig, arg1: &mut PublicationSubscription, arg2: &mut 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::Publication, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::get_subscription_price(arg2);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg1.subscriber == v0, 401);
        assert!(arg1.publication_id == 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::get_publication_object_id(arg2), 401);
        assert!(v1 > 0, 402);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v3 >= v1, 403);
        let v4 = v3 / v1;
        let v5 = v4;
        assert!(v4 > 0, 404);
        if (v4 > 36) {
            v5 = 36;
        };
        let v6 = v5 * v1;
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0);
        };
        let v7 = if (arg1.expires_at > v2) {
            arg1.expires_at
        } else {
            v2
        };
        arg1.expires_at = v7 + v5 * 2592000000;
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::add_subscription_balance(arg2, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v6, arg5)));
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::inkray_events::emit_publication_subscription_extended(0x2::object::uid_to_inner(&arg1.id), arg1.publication_id, v0, v6, arg1.expires_at);
    }

    public fun is_subscription_valid(arg0: &PublicationSubscription, arg1: &0x2::clock::Clock) : bool {
        arg0.expires_at > 0x2::clock::timestamp_ms(arg1)
    }

    public fun subscribe_to_publication(arg0: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::GlobalConfig, arg1: &mut 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::Publication, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::get_subscription_price(arg1);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 > 0, 402);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v3 >= v1, 403);
        let v4 = v3 / v1;
        let v5 = v4;
        assert!(v4 > 0, 404);
        if (v4 > 36) {
            v5 = 36;
        };
        let v6 = v5 * v1;
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        };
        let v7 = v2 + v5 * 2592000000;
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::add_subscription_balance(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v6, arg4)));
        let v8 = 0x2::object::new(arg4);
        let v9 = 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::get_publication_object_id(arg1);
        let v10 = PublicationSubscription{
            id             : v8,
            publication_id : v9,
            subscriber     : v0,
            expires_at     : v7,
            created_at     : v2,
        };
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::inkray_events::emit_publication_subscription_created(0x2::object::uid_to_inner(&v8), v9, v0, v6, v7);
        0x2::transfer::transfer<PublicationSubscription>(v10, v0);
    }

    public fun validate_subscription_access(arg0: &PublicationSubscription, arg1: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::Publication, arg2: address, arg3: &0x2::clock::Clock) : bool {
        if (arg0.publication_id != 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::get_publication_object_id(arg1)) {
            return false
        };
        if (arg0.subscriber != arg2) {
            return false
        };
        is_subscription_valid(arg0, arg3)
    }

    // decompiled from Move bytecode v7
}

