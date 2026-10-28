module 0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::holder_book {
    struct DelegateKey has copy, drop, store {
        account_id: 0x2::object::ID,
        delegate: address,
    }

    struct HolderKey has copy, drop, store {
        holder: address,
    }

    struct OwnerKey has copy, drop, store {
        account_id: 0x2::object::ID,
    }

    public fun account_of(arg0: &0x2::object::UID, arg1: address) : 0x2::object::ID {
        let v0 = HolderKey{holder: arg1};
        *0x2::dynamic_field::borrow<HolderKey, 0x2::object::ID>(arg0, v0)
    }

    public fun add_delegate(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: address) {
        if (!is_delegate(arg0, arg1, arg2)) {
            let v0 = DelegateKey{
                account_id : arg1,
                delegate   : arg2,
            };
            0x2::dynamic_field::add<DelegateKey, bool>(arg0, v0, true);
        };
    }

    public fun holds(arg0: &0x2::object::UID, arg1: address) : bool {
        let v0 = HolderKey{holder: arg1};
        0x2::dynamic_field::exists<HolderKey>(arg0, v0)
    }

    public fun is_delegate(arg0: &0x2::object::UID, arg1: 0x2::object::ID, arg2: address) : bool {
        let v0 = DelegateKey{
            account_id : arg1,
            delegate   : arg2,
        };
        0x2::dynamic_field::exists<DelegateKey>(arg0, v0)
    }

    public fun move_holder(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: address, arg3: address) {
        assert!(!holds(arg0, arg3), 13835058287210397697);
        let v0 = HolderKey{holder: arg2};
        0x2::dynamic_field::remove<HolderKey, 0x2::object::ID>(arg0, v0);
        let v1 = HolderKey{holder: arg3};
        0x2::dynamic_field::add<HolderKey, 0x2::object::ID>(arg0, v1, arg1);
        let v2 = OwnerKey{account_id: arg1};
        if (0x2::dynamic_field::exists<OwnerKey>(arg0, v2)) {
            *0x2::dynamic_field::borrow_mut<OwnerKey, address>(arg0, v2) = arg3;
        } else {
            0x2::dynamic_field::add<OwnerKey, address>(arg0, v2, arg3);
        };
    }

    public fun owner_of(arg0: &0x2::object::UID, arg1: 0x2::object::ID, arg2: address) : address {
        let v0 = OwnerKey{account_id: arg1};
        if (0x2::dynamic_field::exists<OwnerKey>(arg0, v0)) {
            *0x2::dynamic_field::borrow<OwnerKey, address>(arg0, v0)
        } else {
            arg2
        }
    }

    public fun register(arg0: &mut 0x2::object::UID, arg1: address, arg2: 0x2::object::ID) {
        assert!(!holds(arg0, arg1), 13835058252850659329);
        let v0 = HolderKey{holder: arg1};
        0x2::dynamic_field::add<HolderKey, 0x2::object::ID>(arg0, v0, arg2);
    }

    public fun remove_delegate(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: address) {
        if (is_delegate(arg0, arg1, arg2)) {
            let v0 = DelegateKey{
                account_id : arg1,
                delegate   : arg2,
            };
            0x2::dynamic_field::remove<DelegateKey, bool>(arg0, v0);
        };
    }

    // decompiled from Move bytecode v7
}

