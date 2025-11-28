module 0xa769c811d12038ab6b01ff4526d7e82191c2c66fb983cbf642a2b523dc70149f::account {
    struct Account has key {
        id: 0x2::object::UID,
    }

    struct AccountRoot has key {
        id: 0x2::object::UID,
    }

    public fun create(arg0: &mut AccountRoot, arg1: &0x2::tx_context::TxContext) : Account {
        create_for(arg0, 0x2::tx_context::sender(arg1))
    }

    public fun create_for(arg0: &mut AccountRoot, arg1: address) : Account {
        Account{id: 0x2::derived_object::claim<address>(&mut arg0.id, arg1)}
    }

    public fun derive_account_address(arg0: &AccountRoot, arg1: address) : address {
        0x2::derived_object::derive_address<address>(0x2::object::uid_to_inner(&arg0.id), arg1)
    }

    public fun derive_account_id(arg0: &AccountRoot, arg1: address) : 0x2::object::ID {
        0x2::object::id_from_address(derive_account_address(arg0, arg1))
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

    public fun keep(arg0: &mut AccountRoot, arg1: Account, arg2: &mut 0x2::tx_context::TxContext) {
        transfer_to_owner(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    public fun multi_receive<T0: store + key>(arg0: &mut Account, arg1: vector<0x2::transfer::Receiving<T0>>) : vector<T0> {
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

    public fun receive<T0: store + key>(arg0: &mut Account, arg1: 0x2::transfer::Receiving<T0>) : T0 {
        0x2::transfer::public_receive<T0>(&mut arg0.id, arg1)
    }

    public fun transfer_to_owner(arg0: &mut AccountRoot, arg1: Account, arg2: address) {
        assert!(0x2::object::uid_to_address(&arg1.id) == derive_account_address(arg0, arg2), 1);
        0x2::transfer::transfer<Account>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

