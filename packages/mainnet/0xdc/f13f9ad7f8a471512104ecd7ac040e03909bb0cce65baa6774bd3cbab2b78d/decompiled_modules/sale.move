module 0xdcf13f9ad7f8a471512104ecd7ac040e03909bb0cce65baa6774bd3cbab2b78d::sale {
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

    public fun authorize<T0>(arg0: &mut 0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::Pressing, arg1: &0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::PressingAdminCap, arg2: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg3: u64, arg4: u64) {
        0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::authorize_distributor<0xdcf13f9ad7f8a471512104ecd7ac040e03909bb0cce65baa6774bd3cbab2b78d::witness::Witness>(arg0, arg1);
        let v0 = 0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::uid_mut(arg0, arg1);
        assert!(0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg2) == 0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::release_id(arg0), 0);
        assert!(0x767a4ccea4c995b84124dd971e6bbc322db141cfe0d2fb4fcd8b36a6b1a707be::release_license::has_license(arg2), 2);
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

    fun borrow_sale<T0>(arg0: &0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::Pressing) : &RecordSale<T0> {
        let v0 = 0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::uid(arg0);
        let v1 = RecordSaleKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<RecordSaleKey>(v0, v1), 4);
        let v2 = RecordSaleKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<RecordSaleKey, RecordSale<T0>>(v0, v2), 6);
        let v3 = RecordSaleKey{dummy_field: false};
        0x2::dynamic_field::borrow<RecordSaleKey, RecordSale<T0>>(v0, v3)
    }

    public fun has_sale(arg0: &0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::Pressing) : bool {
        let v0 = RecordSaleKey{dummy_field: false};
        0x2::dynamic_field::exists<RecordSaleKey>(0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::uid(arg0), v0)
    }

    public fun is_currency<T0>(arg0: &0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::Pressing) : bool {
        let v0 = RecordSaleKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<RecordSaleKey, RecordSale<T0>>(0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::uid(arg0), v0)
    }

    public fun is_started<T0>(arg0: &0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::Pressing, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= borrow_sale<T0>(arg0).starts_at_ms
    }

    public fun price<T0>(arg0: &0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::Pressing) : u64 {
        borrow_sale<T0>(arg0).price
    }

    public fun purchase<T0>(arg0: &mut 0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::Pressing, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg2: &0x767a4ccea4c995b84124dd971e6bbc322db141cfe0d2fb4fcd8b36a6b1a707be::release_license::ReleaseLicense, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock) : 0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::record::Record {
        assert!(0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg1) == 0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::release_id(arg0), 0);
        assert!(0x767a4ccea4c995b84124dd971e6bbc322db141cfe0d2fb4fcd8b36a6b1a707be::release_license::is_authorized(arg2), 3);
        let v0 = *borrow_sale<T0>(arg0);
        assert!(0x2::clock::timestamp_ms(arg4) >= v0.starts_at_ms, 7);
        assert!(0x2::balance::value<T0>(&arg3) == v0.price, 1);
        let v1 = 0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::record::new<0xdcf13f9ad7f8a471512104ecd7ac040e03909bb0cce65baa6774bd3cbab2b78d::witness::Witness>(arg0, 0xdcf13f9ad7f8a471512104ecd7ac040e03909bb0cce65baa6774bd3cbab2b78d::witness::new());
        let v2 = RecordSoldEvent<T0>{
            record_id   : 0x2::object::id<0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::record::Record>(&v1),
            pressing_id : 0x2::object::id<0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::Pressing>(arg0),
            price       : v0.price,
        };
        0x2::event::emit<RecordSoldEvent<T0>>(v2);
        0x767a4ccea4c995b84124dd971e6bbc322db141cfe0d2fb4fcd8b36a6b1a707be::release_license::forward<T0>(arg2, arg1, arg3);
        v1
    }

    public fun starts_at_ms<T0>(arg0: &0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::Pressing) : u64 {
        borrow_sale<T0>(arg0).starts_at_ms
    }

    public fun update<T0>(arg0: &mut 0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::Pressing, arg1: &0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::PressingAdminCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::uid_mut(arg0, arg1);
        let v1 = RecordSaleKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<RecordSaleKey>(v0, v1), 4);
        let v2 = RecordSaleKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<RecordSaleKey, RecordSale<T0>>(v0, v2), 6);
        let v3 = RecordSaleKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<RecordSaleKey, RecordSale<T0>>(v0, v3);
        assert!(0x2::clock::timestamp_ms(arg4) < v4.starts_at_ms, 8);
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

