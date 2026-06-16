module 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication {
    struct Publication has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        contributors: vector<address>,
        vault_id: 0x2::object::ID,
        tip_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_tips_received: u64,
        total_amount_received: u64,
        subscription_price: u64,
        subscription_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct PublicationOwnerCap has store, key {
        id: 0x2::object::UID,
        publication_id: 0x2::object::ID,
    }

    public fun add_contributor(arg0: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::GlobalConfig, arg1: &PublicationOwnerCap, arg2: &mut Publication, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::assert_version(arg0);
        assert!(arg1.publication_id == 0x2::object::uid_to_inner(&arg2.id), 101);
        assert!(!0x1::vector::contains<address>(&arg2.contributors, &arg3), 103);
        assert!(0x1::vector::length<address>(&arg2.contributors) < 1000, 104);
        0x1::vector::push_back<address>(&mut arg2.contributors, arg3);
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::inkray_events::emit_contributor_added(0x2::object::uid_to_inner(&arg2.id), arg3, 0x2::tx_context::sender(arg4));
    }

    public(friend) fun add_subscription_balance(arg0: &mut Publication, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.subscription_balance, arg1);
    }

    public(friend) fun add_tip_balance(arg0: &mut Publication, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.tip_balance, arg1);
        arg0.total_tips_received = arg0.total_tips_received + 1;
        arg0.total_amount_received = arg0.total_amount_received + 0x2::balance::value<0x2::sui::SUI>(&arg1);
    }

    public fun create(arg0: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::GlobalConfig, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : PublicationOwnerCap {
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::assert_version(arg0);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::vault::create_and_share_vault(v1, arg2);
        let v3 = Publication{
            id                    : v0,
            name                  : arg1,
            contributors          : 0x1::vector::empty<address>(),
            vault_id              : v2,
            tip_balance           : 0x2::balance::zero<0x2::sui::SUI>(),
            total_tips_received   : 0,
            total_amount_received : 0,
            subscription_price    : 0,
            subscription_balance  : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v4 = PublicationOwnerCap{
            id             : 0x2::object::new(arg2),
            publication_id : v1,
        };
        0x2::transfer::share_object<Publication>(v3);
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::inkray_events::emit_publication_created(v1, 0x2::tx_context::sender(arg2), arg1, v2);
        v4
    }

    public fun get_owner_cap_publication_id(arg0: &PublicationOwnerCap) : 0x2::object::ID {
        arg0.publication_id
    }

    public fun get_publication_address(arg0: &Publication) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun get_publication_object_id(arg0: &Publication) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_subscription_price(arg0: &Publication) : u64 {
        arg0.subscription_price
    }

    public fun get_tip_balance(arg0: &Publication) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.tip_balance)
    }

    public fun get_vault_id(arg0: &Publication) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun is_contributor(arg0: &Publication, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.contributors, &arg1)
    }

    public(friend) fun remove_blob_from_vault(arg0: &Publication, arg1: &mut 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::vault::PublicationVault, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob {
        assert!(0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::vault::get_vault_publication_id(arg1) == 0x2::object::uid_to_inner(&arg0.id), 101);
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::vault::remove_blob(arg1, arg2, 0x2::tx_context::sender(arg3))
    }

    public fun remove_contributor(arg0: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::GlobalConfig, arg1: &PublicationOwnerCap, arg2: &mut Publication, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::assert_version(arg0);
        assert!(arg1.publication_id == 0x2::object::uid_to_inner(&arg2.id), 101);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg2.contributors, &arg3);
        assert!(v0, 102);
        0x1::vector::remove<address>(&mut arg2.contributors, v1);
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::inkray_events::emit_contributor_removed(0x2::object::uid_to_inner(&arg2.id), arg3, 0x2::tx_context::sender(arg4));
    }

    public fun requires_subscription(arg0: &Publication) : bool {
        arg0.subscription_price > 0
    }

    public fun set_subscription_price(arg0: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::GlobalConfig, arg1: &PublicationOwnerCap, arg2: &mut Publication, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::assert_version(arg0);
        assert!(arg1.publication_id == 0x2::object::uid_to_inner(&arg2.id), 101);
        assert!(arg3 == 0 || arg3 >= 10000000, 105);
        arg2.subscription_price = arg3;
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::inkray_events::emit_publication_subscription_price_updated(0x2::object::uid_to_inner(&arg2.id), arg2.subscription_price, arg3, 0x2::tx_context::sender(arg4));
    }

    public(friend) fun store_blob_in_vault(arg0: &Publication, arg1: &mut 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::vault::PublicationVault, arg2: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::vault::get_vault_publication_id(arg1) == 0x2::object::uid_to_inner(&arg0.id), 101);
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::vault::store_blob(arg1, arg2, 0x2::tx_context::sender(arg3));
    }

    public fun update_name(arg0: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::GlobalConfig, arg1: &PublicationOwnerCap, arg2: &mut Publication, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::assert_version(arg0);
        assert!(arg1.publication_id == 0x2::object::uid_to_inner(&arg2.id), 101);
        arg2.name = arg3;
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::inkray_events::emit_publication_name_updated(0x2::object::uid_to_inner(&arg2.id), arg2.name, arg3, 0x2::tx_context::sender(arg4));
    }

    public fun verify_owner_cap(arg0: &PublicationOwnerCap, arg1: &Publication) : bool {
        arg0.publication_id == 0x2::object::uid_to_inner(&arg1.id)
    }

    public fun withdraw_subscription_balance(arg0: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::GlobalConfig, arg1: &PublicationOwnerCap, arg2: &mut Publication, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::assert_version(arg0);
        assert!(arg1.publication_id == 0x2::object::uid_to_inner(&arg2.id), 101);
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::inkray_events::emit_subscription_balance_withdrawn(0x2::object::uid_to_inner(&arg2.id), arg3, 0x2::tx_context::sender(arg4));
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.subscription_balance, arg3), arg4)
    }

    public(friend) fun withdraw_tip_balance(arg0: &mut Publication, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.tip_balance, arg1), arg2)
    }

    // decompiled from Move bytecode v7
}

