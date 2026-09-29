module 0x58963d30f5f9902a53c267d815c87d8d833ab1142618add331ea1f4e17dcab9b::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        owner: address,
        ids: vector<0x2::object::ID>,
    }

    struct Loan {
        vault_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
    }

    public fun length(arg0: &Vault) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.ids)
    }

    public fun borrow<T0: store + key>(arg0: &mut Vault, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : (T0, Loan) {
        assert_owner(arg0, arg2);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg0.ids, &arg1), 2);
        let v0 = Loan{
            vault_id : 0x2::object::id<Vault>(arg0),
            item_id  : arg1,
        };
        (0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1), v0)
    }

    public fun contains(arg0: &Vault, arg1: 0x2::object::ID) : bool {
        0x1::vector::contains<0x2::object::ID>(&arg0.ids, &arg1)
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : Vault {
        Vault{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
            ids   : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    fun assert_owner(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Vault>(new(arg0));
    }

    public fun deposit<T0: store + key>(arg0: &mut Vault, arg1: T0, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        let v0 = 0x2::object::id<T0>(&arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v0, arg1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.ids, v0);
    }

    public fun ids(arg0: &Vault) : vector<0x2::object::ID> {
        arg0.ids
    }

    public fun owner(arg0: &Vault) : address {
        arg0.owner
    }

    public fun put_back<T0: store + key>(arg0: &mut Vault, arg1: T0, arg2: Loan) {
        let Loan {
            vault_id : v0,
            item_id  : v1,
        } = arg2;
        assert!(v0 == 0x2::object::id<Vault>(arg0), 3);
        assert!(0x2::object::id<T0>(&arg1) == v1, 2);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v1, arg1);
    }

    public fun take<T0: store + key>(arg0: &mut Vault, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : T0 {
        assert_owner(arg0, arg2);
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.ids, &arg1);
        assert!(v0, 2);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.ids, v1);
        0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1)
    }

    public fun take_latest<T0: store + key>(arg0: &mut Vault, arg1: &0x2::tx_context::TxContext) : T0 {
        assert_owner(arg0, arg1);
        assert!(!0x1::vector::is_empty<0x2::object::ID>(&arg0.ids), 1);
        0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, 0x1::vector::pop_back<0x2::object::ID>(&mut arg0.ids))
    }

    public fun withdraw<T0: store + key>(arg0: &mut Vault, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        let v0 = arg0.owner;
        0x2::transfer::public_transfer<T0>(take<T0>(arg0, arg1, arg2), v0);
    }

    // decompiled from Move bytecode v7
}

