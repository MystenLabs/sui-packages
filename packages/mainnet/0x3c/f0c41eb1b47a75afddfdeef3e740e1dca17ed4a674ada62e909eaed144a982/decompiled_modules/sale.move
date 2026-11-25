module 0x3cf0c41eb1b47a75afddfdeef3e740e1dca17ed4a674ada62e909eaed144a982::sale {
    struct RecordSale<phantom T0> has copy, drop, store {
        price: u64,
        starts_at_ms: u64,
    }

    struct RecordSaleKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SaleAuthorizedEvent<phantom T0> has copy, drop {
        pressing_id: 0x2::object::ID,
        price: u64,
        starts_at_ms: u64,
    }

    struct SaleUpdatedEvent<phantom T0> has copy, drop {
        pressing_id: 0x2::object::ID,
        price: u64,
        starts_at_ms: u64,
    }

    struct RecordSoldEvent<phantom T0> has copy, drop {
        record_id: 0x2::object::ID,
        pressing_id: 0x2::object::ID,
        price: u64,
    }

    public fun authorize<T0>(arg0: &mut 0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::pressing::Pressing, arg1: &0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::pressing::PressingAdminCap, arg2: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg3: u64, arg4: u64) {
        0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::pressing::authorize_distributor<0x3cf0c41eb1b47a75afddfdeef3e740e1dca17ed4a674ada62e909eaed144a982::witness::Witness>(arg0, arg1);
        let v0 = 0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::pressing::uid_mut(arg0, arg1);
        assert!(0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg2) == 0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::pressing::release_id(arg0), 0);
        assert!(0x73c189fe3357bfd3eede39c646a2bcc277362708f3e8e209f1fcca9be748d42e::release_license::has_license(arg2), 2);
        let v1 = RecordSaleKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<RecordSaleKey>(v0, v1), 5);
        let v2 = RecordSaleKey{dummy_field: false};
        let v3 = RecordSale<T0>{
            price        : arg3,
            starts_at_ms : arg4,
        };
        0x2::dynamic_field::add<RecordSaleKey, RecordSale<T0>>(v0, v2, v3);
        let v4 = SaleAuthorizedEvent<T0>{
            pressing_id  : 0x2::object::uid_to_inner(v0),
            price        : arg3,
            starts_at_ms : arg4,
        };
        0x2::event::emit<SaleAuthorizedEvent<T0>>(v4);
    }

    fun borrow_sale<T0>(arg0: &0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::pressing::Pressing) : &RecordSale<T0> {
        let v0 = 0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::pressing::uid(arg0);
        let v1 = RecordSaleKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<RecordSaleKey>(v0, v1), 4);
        let v2 = RecordSaleKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<RecordSaleKey, RecordSale<T0>>(v0, v2), 6);
        let v3 = RecordSaleKey{dummy_field: false};
        0x2::dynamic_field::borrow<RecordSaleKey, RecordSale<T0>>(v0, v3)
    }

    public fun has_sale(arg0: &0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::pressing::Pressing) : bool {
        let v0 = RecordSaleKey{dummy_field: false};
        0x2::dynamic_field::exists<RecordSaleKey>(0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::pressing::uid(arg0), v0)
    }

    public fun is_currency<T0>(arg0: &0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::pressing::Pressing) : bool {
        let v0 = RecordSaleKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<RecordSaleKey, RecordSale<T0>>(0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::pressing::uid(arg0), v0)
    }

    public fun is_started<T0>(arg0: &0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::pressing::Pressing) : bool {
        0x2::clock::timestamp_ms(0x2::clock::borrow()) >= borrow_sale<T0>(arg0).starts_at_ms
    }

    public fun price<T0>(arg0: &0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::pressing::Pressing) : u64 {
        borrow_sale<T0>(arg0).price
    }

    public fun purchase<T0>(arg0: &mut 0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::pressing::Pressing, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg2: &0x73c189fe3357bfd3eede39c646a2bcc277362708f3e8e209f1fcca9be748d42e::release_license::ReleaseLicense, arg3: 0x2::balance::Balance<T0>) : 0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::record::Record {
        assert!(0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg1) == 0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::pressing::release_id(arg0), 0);
        assert!(0x73c189fe3357bfd3eede39c646a2bcc277362708f3e8e209f1fcca9be748d42e::release_license::is_authorized(arg2), 3);
        let v0 = *borrow_sale<T0>(arg0);
        assert!(0x2::clock::timestamp_ms(0x2::clock::borrow()) >= v0.starts_at_ms, 7);
        assert!(0x2::balance::value<T0>(&arg3) == v0.price, 1);
        let v1 = 0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::record::new<0x3cf0c41eb1b47a75afddfdeef3e740e1dca17ed4a674ada62e909eaed144a982::witness::Witness>(arg0, 0x3cf0c41eb1b47a75afddfdeef3e740e1dca17ed4a674ada62e909eaed144a982::witness::new());
        let v2 = RecordSoldEvent<T0>{
            record_id   : 0x2::object::id<0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::record::Record>(&v1),
            pressing_id : 0x2::object::id<0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::pressing::Pressing>(arg0),
            price       : v0.price,
        };
        0x2::event::emit<RecordSoldEvent<T0>>(v2);
        0x73c189fe3357bfd3eede39c646a2bcc277362708f3e8e209f1fcca9be748d42e::release_license::forward<T0>(arg2, arg1, arg3);
        v1
    }

    public fun starts_at_ms<T0>(arg0: &0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::pressing::Pressing) : u64 {
        borrow_sale<T0>(arg0).starts_at_ms
    }

    public fun update<T0>(arg0: &mut 0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::pressing::Pressing, arg1: &0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::pressing::PressingAdminCap, arg2: u64, arg3: u64) {
        let v0 = 0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::pressing::uid_mut(arg0, arg1);
        let v1 = RecordSaleKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<RecordSaleKey>(v0, v1), 4);
        let v2 = RecordSaleKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<RecordSaleKey, RecordSale<T0>>(v0, v2), 6);
        let v3 = RecordSaleKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<RecordSaleKey, RecordSale<T0>>(v0, v3);
        assert!(0x2::clock::timestamp_ms(0x2::clock::borrow()) < v4.starts_at_ms, 8);
        if (v4.price == arg2 && v4.starts_at_ms == arg3) {
            return
        };
        v4.price = arg2;
        v4.starts_at_ms = arg3;
        let v5 = SaleUpdatedEvent<T0>{
            pressing_id  : 0x2::object::uid_to_inner(v0),
            price        : arg2,
            starts_at_ms : arg3,
        };
        0x2::event::emit<SaleUpdatedEvent<T0>>(v5);
    }

    // decompiled from Move bytecode v7
}

