module 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage {
    struct PriceFeedKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct PriceFeedStorage has store, key {
        id: 0x2::object::UID,
        symbol: 0x1::string::String,
        sources: vector<0x2::object::ID>,
    }

    public fun contains(arg0: &PriceFeedStorage, arg1: 0x2::object::ID) : bool {
        0x1::vector::contains<0x2::object::ID>(&arg0.sources, &arg1)
    }

    public fun new<T0>(arg0: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::AuthorityCap<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::PACKAGE, T0>, arg1: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : PriceFeedStorage {
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::assert_package_version(arg1);
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::assert_authority_cap_is_valid<T0>(arg1, arg0);
        let v0 = PriceFeedStorage{
            id      : 0x2::object::new(arg3),
            symbol  : arg2,
            sources : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::events::emit_created_price_feed_storage(0x2::object::uid_to_inner(&v0.id), arg2);
        v0
    }

    public fun price_feed(arg0: &PriceFeedStorage, arg1: 0x2::object::ID) : &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed::PriceFeed {
        assert!(contains(arg0, arg1), 2);
        let v0 = PriceFeedKey{pos0: arg1};
        0x2::dynamic_field::borrow<PriceFeedKey, 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed::PriceFeed>(&arg0.id, v0)
    }

    public fun any_source(arg0: &PriceFeedStorage) : bool {
        !0x1::vector::is_empty<0x2::object::ID>(&arg0.sources)
    }

    public fun new_price_feed<T0, T1: key>(arg0: &mut PriceFeedStorage, arg1: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::AuthorityCap<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::PACKAGE, T0>, arg2: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg3: &0x2::object::UID, arg4: &T1, arg5: u256, arg6: u256, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::assert_package_version(arg2);
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::assert_authority_cap_is_valid<T0>(arg2, arg1);
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::assert_source_has_been_authorized(arg3);
        let v0 = 0x2::object::uid_to_inner(arg3);
        assert!(!contains(arg0, v0), 1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.sources, v0);
        let v1 = PriceFeedKey{pos0: v0};
        0x2::dynamic_field::add<PriceFeedKey, 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed::PriceFeed>(&mut arg0.id, v1, 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed::new(0x2::object::id<T1>(arg4), arg5, arg6, arg7, arg8));
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::events::emit_created_price_feed(0x2::object::uid_to_inner(&arg0.id), v0, arg5, arg6, arg7);
    }

    fun price_feed_mut(arg0: &mut PriceFeedStorage, arg1: 0x2::object::ID) : &mut 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed::PriceFeed {
        assert!(contains(arg0, arg1), 2);
        let v0 = PriceFeedKey{pos0: arg1};
        0x2::dynamic_field::borrow_mut<PriceFeedKey, 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed::PriceFeed>(&mut arg0.id, v0)
    }

    public fun remove_price_feed<T0>(arg0: &mut PriceFeedStorage, arg1: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::AuthorityCap<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::PACKAGE, T0>, arg2: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg3: &0x2::object::UID) {
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::assert_package_version(arg2);
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::assert_authority_cap_is_valid<T0>(arg2, arg1);
        let v0 = 0x2::object::uid_to_inner(arg3);
        let v1 = &arg0.sources;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x2::object::ID>(v1)) {
            if (0x1::vector::borrow<0x2::object::ID>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                0x1::vector::remove<0x2::object::ID>(&mut arg0.sources, 0x1::option::destroy_some<u64>(v3));
                let v4 = PriceFeedKey{pos0: v0};
                0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed::destroy(0x2::dynamic_field::remove<PriceFeedKey, 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed::PriceFeed>(&mut arg0.id, v4));
                0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::events::emit_removed_price_feed(0x2::object::uid_to_inner(&arg0.id), v0);
                return
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
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
        0x1::vector::length<0x2::object::ID>(&arg0.sources)
    }

    public fun sources(arg0: &PriceFeedStorage) : &vector<0x2::object::ID> {
        &arg0.sources
    }

    public fun symbol(arg0: &PriceFeedStorage) : 0x1::string::String {
        arg0.symbol
    }

    public fun update_price_feed<T0: key>(arg0: &mut PriceFeedStorage, arg1: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg2: &0x2::object::UID, arg3: &T0, arg4: u256, arg5: u256, arg6: u64) {
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::assert_package_version(arg1);
        let v0 = 0x2::object::uid_to_inner(arg2);
        let v1 = price_feed_mut(arg0, v0);
        assert!(0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed::from(v1) == 0x2::object::id<T0>(arg3), 0);
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed::set_price(v1, arg4, arg5, arg6);
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::events::emit_updated_price_feed(0x2::object::uid_to_inner(&arg0.id), v0, 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed::price(v1), 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed::timestamp(v1), arg4, arg5, arg6);
    }

    entry fun update_symbol_info(arg0: &mut PriceFeedStorage, arg1: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::AuthorityCap<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::PACKAGE, 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::ADMIN>, arg2: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg3: 0x1::string::String) {
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::assert_package_version(arg2);
        arg0.symbol = arg3;
    }

    // decompiled from Move bytecode v6
}

