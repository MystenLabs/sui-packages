module 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage {
    struct PriceFeedStorageKey has copy, drop, store {
        pos0: u32,
    }

    struct PriceFeedStorage has store, key {
        id: 0x2::object::UID,
        storage_id: u32,
        symbol: 0x1::string::String,
        feeds: vector<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed::PriceFeed>,
    }

    public fun has_vendor_authorization<T0>(arg0: &PriceFeedStorage) : bool {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::has_vendor_authorization<T0>(&arg0.id)
    }

    public fun price_feed(arg0: &PriceFeedStorage, arg1: u16) : &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed::PriceFeed {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed::borrow_feed(&arg0.feeds, arg1)
    }

    public fun contains(arg0: &PriceFeedStorage, arg1: u16) : bool {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed::contains(&arg0.feeds, arg1)
    }

    public fun any_source(arg0: &PriceFeedStorage) : bool {
        !0x1::vector::is_empty<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed::PriceFeed>(&arg0.feeds)
    }

    public fun assert_has_vendor_authorization<T0>(arg0: &PriceFeedStorage) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::assert_has_active_vendor_authority<T0>(&arg0.id);
    }

    public fun derived_id(arg0: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg1: u32) : 0x2::object::ID {
        let v0 = PriceFeedStorageKey{pos0: arg1};
        0x2::object::id_from_address(0x2::derived_object::derive_address<PriceFeedStorageKey>(0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::id(arg0), v0))
    }

    public fun feeds(arg0: &PriceFeedStorage) : &vector<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed::PriceFeed> {
        &arg0.feeds
    }

    public fun force_remove_price_feed<T0>(arg0: &mut PriceFeedStorage, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T0>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg3: u16) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::assert_package_version(arg2);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::assert_is_admin_or_assistant<T0>();
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::assert_package_authority_cap_is_valid<T0>(arg2, arg1);
        remove_price_feed_(arg0, arg3);
    }

    public fun new<T0, T1>(arg0: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, T1>, arg2: 0x1::string::String) : PriceFeedStorage {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::assert_package_version(arg0);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::assert_is_admin_or_assistant<T1>();
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::assert_vendor_authority_cap_is_valid<T0, T1>(arg0, arg1);
        let v0 = 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::inc_storage_id(arg0);
        let v1 = PriceFeedStorageKey{pos0: v0};
        let v2 = PriceFeedStorage{
            id         : 0x2::derived_object::claim<PriceFeedStorageKey>(0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::borrow_mut_id(arg0), v1),
            storage_id : v0,
            symbol     : arg2,
            feeds      : 0x1::vector::empty<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed::PriceFeed>(),
        };
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::add_vendor_authorization<T0>(&mut v2.id);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::events::emit_created_price_feed_storage(0x2::object::uid_to_inner(&v2.id), v0, arg2);
        v2
    }

    public fun new_price_feed<T0, T1, T2: key>(arg0: &mut PriceFeedStorage, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg3: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::SourceCap, arg4: &T2, arg5: u128, arg6: u64, arg7: u64) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::assert_package_version(arg2);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::assert_is_admin_or_assistant<T1>();
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::assert_vendor_authority_cap_is_valid<T0, T1>(arg2, arg1);
        assert_has_vendor_authorization<T0>(arg0);
        assert!(0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::is_authorized(arg3), 13835340896058605571);
        let v0 = 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::source_id(arg3);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed::add_feed(&mut arg0.feeds, v0, 0x2::object::id<T2>(arg4), arg5, arg6, arg7);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::events::emit_created_price_feed(arg0.storage_id, v0, arg5, arg6);
    }

    fun price_feed_mut(arg0: &mut PriceFeedStorage, arg1: u16) : &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed::PriceFeed {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed::borrow_feed_mut(&mut arg0.feeds, arg1)
    }

    public fun remove_price_feed<T0>(arg0: &mut PriceFeedStorage, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg3: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::SourceCap) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::assert_package_version(arg2);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::assert_vendor_authority_cap_is_valid<T0, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(arg2, arg1);
        assert_has_vendor_authorization<T0>(arg0);
        remove_price_feed_(arg0, 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::source_id(arg3));
    }

    fun remove_price_feed_(arg0: &mut PriceFeedStorage, arg1: u16) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed::remove_feed(&mut arg0.feeds, arg1);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::events::emit_removed_price_feed(arg0.storage_id, arg1);
    }

    entry fun set_symbol<T0, T1>(arg0: &mut PriceFeedStorage, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg3: 0x1::string::String) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::assert_package_version(arg2);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::assert_is_admin_or_maintenance<T1>();
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::assert_vendor_authority_cap_is_valid<T0, T1>(arg2, arg1);
        assert_has_vendor_authorization<T0>(arg0);
        arg0.symbol = arg3;
    }

    public fun set_twap_period_ms<T0, T1>(arg0: &mut PriceFeedStorage, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg3: u16, arg4: u64) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::assert_package_version(arg2);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::assert_is_admin_or_maintenance<T1>();
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::assert_vendor_authority_cap_is_valid<T0, T1>(arg2, arg1);
        assert_has_vendor_authorization<T0>(arg0);
        let v0 = price_feed_mut(arg0, arg3);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::events::emit_updated_twap_period_ms(arg0.storage_id, arg3, 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed::set_feed_twap_period_ms(v0, arg4), arg4);
    }

    public fun share_vec(arg0: vector<PriceFeedStorage>) {
        0x1::vector::reverse<PriceFeedStorage>(&mut arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<PriceFeedStorage>(&arg0)) {
            0x2::transfer::share_object<PriceFeedStorage>(0x1::vector::pop_back<PriceFeedStorage>(&mut arg0));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<PriceFeedStorage>(arg0);
    }

    public fun size(arg0: &PriceFeedStorage) : u64 {
        0x1::vector::length<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed::PriceFeed>(&arg0.feeds)
    }

    public fun sources(arg0: &PriceFeedStorage) : vector<u16> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed::PriceFeed>(&arg0.feeds)) {
            0x1::vector::push_back<u16>(&mut v0, 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed::source_id(0x1::vector::borrow<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed::PriceFeed>(&arg0.feeds, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun storage_id(arg0: &PriceFeedStorage) : u32 {
        arg0.storage_id
    }

    public fun symbol(arg0: &PriceFeedStorage) : 0x1::string::String {
        arg0.symbol
    }

    public fun update_price_feed<T0: key>(arg0: &mut PriceFeedStorage, arg1: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::SourceCap, arg3: &T0, arg4: u128, arg5: u64) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::assert_package_version(arg1);
        assert!(0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::is_authorized(arg2), 13835341656267816963);
        let v0 = 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::source_id(arg2);
        let v1 = price_feed_mut(arg0, v0);
        if (0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed::from(v1) != 0x2::object::id<T0>(arg3)) {
            abort 13835060215650713601
        };
        let (v2, v3, v4) = 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed::price_timestamp_ms_twap_price(v1);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed::set_price(v1, arg4, arg5);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::events::emit_updated_price_feed(arg0.storage_id, v0, v2, v3, v4, arg4, arg5, 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed::twap_price(v1));
    }

    // decompiled from Move bytecode v7
}

