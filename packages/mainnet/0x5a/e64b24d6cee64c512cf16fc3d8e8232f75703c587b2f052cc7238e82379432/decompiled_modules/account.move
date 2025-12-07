module 0x406745eb5464ecde1bc9ee58ef2c209f98964a69f6695139eb7122f620f60b0c::account {
    struct Account has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct AccountRoot has key {
        id: 0x2::object::UID,
    }

    struct AccountKey has copy, drop, store {
        pos0: address,
        pos1: u64,
    }

    public fun assert_owner(arg0: &Account, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
    }

    public fun create(arg0: &mut AccountRoot, arg1: u64, arg2: &0x2::tx_context::TxContext) : Account {
        create_for(arg0, 0x2::tx_context::sender(arg2), arg1)
    }

    public fun create_for(arg0: &mut AccountRoot, arg1: address, arg2: u64) : Account {
        let v0 = AccountKey{
            pos0 : arg1,
            pos1 : arg2,
        };
        Account{
            id    : 0x2::derived_object::claim<vector<u8>>(&mut arg0.id, 0x1::bcs::to_bytes<AccountKey>(&v0)),
            owner : arg1,
        }
    }

    public fun derive_account_address(arg0: &AccountRoot, arg1: address, arg2: u64) : address {
        let v0 = AccountKey{
            pos0 : arg1,
            pos1 : arg2,
        };
        0x2::derived_object::derive_address<vector<u8>>(0x2::object::uid_to_inner(&arg0.id), 0x1::bcs::to_bytes<AccountKey>(&v0))
    }

    public fun derive_account_id(arg0: &AccountRoot, arg1: address, arg2: u64) : 0x2::object::ID {
        0x2::object::id_from_address(derive_account_address(arg0, arg1, arg2))
    }

    public(friend) fun extend(arg0: &mut Account) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun get_address(arg0: &Account) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun id(arg0: &Account) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccountRoot{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<AccountRoot>(v0);
    }

    public fun multi_receive<T0: store + key>(arg0: &mut Account, arg1: vector<0x2::transfer::Receiving<T0>>, arg2: &0x2::tx_context::TxContext) : vector<T0> {
        assert_owner(arg0, arg2);
        let v0 = 0x1::vector::empty<T0>();
        0x1::vector::reverse<0x2::transfer::Receiving<T0>>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::transfer::Receiving<T0>>(&arg1)) {
            0x1::vector::push_back<T0>(&mut v0, 0x2::transfer::public_receive<T0>(&mut arg0.id, 0x1::vector::pop_back<0x2::transfer::Receiving<T0>>(&mut arg1)));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::transfer::Receiving<T0>>(arg1);
        v0
    }

    public fun multi_receive_coins<T0>(arg0: &mut Account, arg1: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_owner(arg0, arg2);
        let v0 = 0x2::coin::zero<T0>(arg2);
        0x1::vector::reverse<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg1)) {
            let v2 = v0;
            0x2::coin::join<T0>(&mut v2, 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, 0x1::vector::pop_back<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&mut arg1)));
            v0 = v2;
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(arg1);
        v0
    }

    public fun receive<T0: store + key>(arg0: &mut Account, arg1: 0x2::transfer::Receiving<T0>, arg2: &0x2::tx_context::TxContext) : T0 {
        assert_owner(arg0, arg2);
        0x2::transfer::public_receive<T0>(&mut arg0.id, arg1)
    }

    public fun share(arg0: Account) {
        0x2::transfer::share_object<Account>(arg0);
    }

    // decompiled from Move bytecode v6
}

