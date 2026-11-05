module 0xdaa3e0c73a3be3c98e28738d44b172b2520fe7041f5c6e65d8c3e8aa77f4d569::sale {
    struct Price has copy, drop, store {
        currency: 0x1::type_name::TypeName,
        value: u64,
    }

    struct PriceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SaleAuthorizedEvent<phantom T0> has copy, drop {
        pressing_id: 0x2::object::ID,
        price: u64,
    }

    struct RecordSoldEvent<phantom T0> has copy, drop {
        record_id: 0x2::object::ID,
        pressing_id: 0x2::object::ID,
        price: u64,
    }

    public fun authorize<T0>(arg0: &mut 0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::Pressing, arg1: &0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::PressingAdminCap, arg2: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg3: u64) {
        0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::authorize_distributor<0xdaa3e0c73a3be3c98e28738d44b172b2520fe7041f5c6e65d8c3e8aa77f4d569::witness::Witness>(arg0, arg1);
        let v0 = 0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::uid_mut(arg0, arg1);
        assert!(0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg2) == 0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::release_id(arg0), 0);
        assert!(0x767a4ccea4c995b84124dd971e6bbc322db141cfe0d2fb4fcd8b36a6b1a707be::release_license::has_license(arg2), 2);
        let v1 = PriceKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<PriceKey>(v0, v1), 5);
        let v2 = PriceKey{dummy_field: false};
        let v3 = Price{
            currency : 0x1::type_name::with_defining_ids<T0>(),
            value    : arg3,
        };
        0x2::dynamic_field::add<PriceKey, Price>(v0, v2, v3);
        let v4 = SaleAuthorizedEvent<T0>{
            pressing_id : 0x2::object::uid_to_inner(v0),
            price       : arg3,
        };
        0x2::event::emit<SaleAuthorizedEvent<T0>>(v4);
    }

    fun borrow_price(arg0: &0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::Pressing) : &Price {
        assert!(has_price(arg0), 4);
        let v0 = PriceKey{dummy_field: false};
        0x2::dynamic_field::borrow<PriceKey, Price>(0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::uid(arg0), v0)
    }

    public fun currency(arg0: &0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::Pressing) : 0x1::type_name::TypeName {
        borrow_price(arg0).currency
    }

    public fun has_price(arg0: &0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::Pressing) : bool {
        let v0 = PriceKey{dummy_field: false};
        0x2::dynamic_field::exists<PriceKey>(0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::uid(arg0), v0)
    }

    public fun price(arg0: &0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::Pressing) : u64 {
        borrow_price(arg0).value
    }

    public fun purchase<T0>(arg0: &mut 0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::Pressing, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg2: &0x767a4ccea4c995b84124dd971e6bbc322db141cfe0d2fb4fcd8b36a6b1a707be::release_license::ReleaseLicense, arg3: 0x2::balance::Balance<T0>) : 0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::record::Record {
        assert!(0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg1) == 0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::release_id(arg0), 0);
        assert!(0x767a4ccea4c995b84124dd971e6bbc322db141cfe0d2fb4fcd8b36a6b1a707be::release_license::is_authorized(arg2), 3);
        let v0 = *borrow_price(arg0);
        assert!(v0.currency == 0x1::type_name::with_defining_ids<T0>(), 6);
        assert!(0x2::balance::value<T0>(&arg3) == v0.value, 1);
        let v1 = 0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::record::new<0xdaa3e0c73a3be3c98e28738d44b172b2520fe7041f5c6e65d8c3e8aa77f4d569::witness::Witness>(arg0, 0xdaa3e0c73a3be3c98e28738d44b172b2520fe7041f5c6e65d8c3e8aa77f4d569::witness::new());
        let v2 = RecordSoldEvent<T0>{
            record_id   : 0x2::object::id<0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::record::Record>(&v1),
            pressing_id : 0x2::object::id<0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::Pressing>(arg0),
            price       : v0.value,
        };
        0x2::event::emit<RecordSoldEvent<T0>>(v2);
        0x767a4ccea4c995b84124dd971e6bbc322db141cfe0d2fb4fcd8b36a6b1a707be::release_license::forward<T0>(arg2, arg1, arg3);
        v1
    }

    // decompiled from Move bytecode v7
}

