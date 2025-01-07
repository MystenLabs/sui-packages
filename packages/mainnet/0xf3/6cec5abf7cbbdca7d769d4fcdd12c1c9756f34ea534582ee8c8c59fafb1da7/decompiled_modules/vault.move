module 0xf36cec5abf7cbbdca7d769d4fcdd12c1c9756f34ea534582ee8c8c59fafb1da7::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        keys: 0x2::table_vec::TableVec<0x1::ascii::String>,
    }

    public(friend) fun borrow<T0>(arg0: &Vault) : &0x2::balance::Balance<T0> {
        0x2::dynamic_field::borrow<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg0.id, 0xf36cec5abf7cbbdca7d769d4fcdd12c1c9756f34ea534582ee8c8c59fafb1da7::utils::get_type_name_string<T0>())
    }

    public(friend) fun borrow_mut<T0>(arg0: &mut Vault) : &mut 0x2::balance::Balance<T0> {
        0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, 0xf36cec5abf7cbbdca7d769d4fcdd12c1c9756f34ea534582ee8c8c59fafb1da7::utils::get_type_name_string<T0>())
    }

    public(friend) fun destroy_empty(arg0: Vault) {
        let Vault {
            id   : v0,
            keys : v1,
        } = arg0;
        let v2 = v1;
        assert!(0x2::table_vec::is_empty<0x1::ascii::String>(&v2), 0);
        0x2::table_vec::drop<0x1::ascii::String>(v2);
        0x2::object::delete(v0);
    }

    public(friend) fun value<T0>(arg0: &mut Vault) : u64 {
        makesure<T0>(arg0);
        0x2::balance::value<T0>(borrow<T0>(arg0))
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Vault {
        Vault{
            id   : 0x2::object::new(arg0),
            keys : 0x2::table_vec::empty<0x1::ascii::String>(arg0),
        }
    }

    public(friend) fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>) {
        makesure<T0>(arg0);
        0x2::balance::join<T0>(borrow_mut<T0>(arg0), 0x2::coin::into_balance<T0>(arg1));
    }

    fun makesure<T0>(arg0: &mut Vault) {
        let v0 = 0xf36cec5abf7cbbdca7d769d4fcdd12c1c9756f34ea534582ee8c8c59fafb1da7::utils::get_type_name_string<T0>();
        if (!0x2::dynamic_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            0x2::dynamic_field::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::balance::zero<T0>());
            0x2::table_vec::push_back<0x1::ascii::String>(&mut arg0.keys, v0);
        };
    }

    public(friend) fun take<T0>(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xf36cec5abf7cbbdca7d769d4fcdd12c1c9756f34ea534582ee8c8c59fafb1da7::utils::get_type_name_string<T0>();
        let v1 = 0;
        while (v1 < 0x2::table_vec::length<0x1::ascii::String>(&arg0.keys)) {
            if (0x2::table_vec::borrow<0x1::ascii::String>(&arg0.keys, v1) == &v0) {
                break
            };
            v1 = v1 + 1;
        };
        0x2::table_vec::swap_remove<0x1::ascii::String>(&mut arg0.keys, v1);
        0x2::coin::from_balance<T0>(0x2::dynamic_field::remove<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1)
    }

    public(friend) fun withdraw<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        makesure<T0>(arg0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(borrow_mut<T0>(arg0), arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

