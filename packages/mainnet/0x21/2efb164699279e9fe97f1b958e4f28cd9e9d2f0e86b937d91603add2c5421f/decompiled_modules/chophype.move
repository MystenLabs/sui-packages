module 0x212efb164699279e9fe97f1b958e4f28cd9e9d2f0e86b937d91603add2c5421f::chophype {
    struct Hype<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        token: 0x2::balance::Balance<T0>,
        tokenType: 0x1::string::String,
        value: u64,
        min_token_amount: u64,
        min_sui_amount: u64,
        updated_at: u64,
        created_at: u64,
    }

    struct NewHype has copy, drop {
        hype_id: 0x2::object::ID,
        owner: address,
        tokenType: 0x1::string::String,
        timestamp: u64,
    }

    struct HypedSui has copy, drop {
        hype_id: 0x2::object::ID,
        owner: address,
        sui: u64,
        tokenType: 0x1::string::String,
        value: u64,
        timestamp: u64,
    }

    struct HypedToken has copy, drop {
        hype_id: 0x2::object::ID,
        owner: address,
        token: u64,
        tokenType: 0x1::string::String,
        value: u64,
        timestamp: u64,
    }

    struct WithdrawHype has copy, drop {
        hype_id: 0x2::object::ID,
        owner: address,
        sui: u64,
        token: u64,
        tokenType: 0x1::string::String,
        timestamp: u64,
    }

    struct TransferHype has copy, drop {
        hype_id: 0x2::object::ID,
        owner: address,
        new_owner: address,
        tokenType: 0x1::string::String,
        timestamp: u64,
    }

    struct ChangeAmountHype has copy, drop {
        hype_id: 0x2::object::ID,
        owner: address,
        min_token_amount: u64,
        min_sui_amount: u64,
        tokenType: 0x1::string::String,
        timestamp: u64,
    }

    public fun create<T0>(arg0: vector<u8>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = Hype<T0>{
            id               : v0,
            owner            : 0x2::tx_context::sender(arg2),
            sui              : 0x2::balance::zero<0x2::sui::SUI>(),
            token            : 0x2::balance::zero<T0>(),
            tokenType        : 0x1::string::utf8(arg0),
            value            : 0,
            min_token_amount : 10000000,
            min_sui_amount   : 100000,
            updated_at       : 0x2::clock::timestamp_ms(arg1),
            created_at       : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::transfer::share_object<Hype<T0>>(v1);
        let v2 = NewHype{
            hype_id   : 0x2::object::uid_to_inner(&v0),
            owner     : 0x2::tx_context::sender(arg2),
            tokenType : 0x1::string::utf8(arg0),
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<NewHype>(v2);
    }

    public fun set_min_amount<T0>(arg0: &mut Hype<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 0);
        arg0.min_sui_amount = arg1;
        arg0.min_token_amount = arg2;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = ChangeAmountHype{
            hype_id          : 0x2::object::uid_to_inner(&arg0.id),
            owner            : 0x2::tx_context::sender(arg4),
            min_token_amount : arg2,
            min_sui_amount   : arg1,
            tokenType        : arg0.tokenType,
            timestamp        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ChangeAmountHype>(v0);
    }

    public fun set_owner<T0>(arg0: &mut Hype<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        arg0.owner = arg1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        let v0 = TransferHype{
            hype_id   : 0x2::object::uid_to_inner(&arg0.id),
            owner     : 0x2::tx_context::sender(arg3),
            new_owner : arg1,
            tokenType : arg0.tokenType,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TransferHype>(v0);
    }

    public fun sui_balance<T0>(arg0: &Hype<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui)
    }

    public fun token_balance<T0>(arg0: &Hype<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.token)
    }

    public fun with_sui<T0>(arg0: &mut Hype<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        assert!(v1 >= arg0.min_sui_amount, 1);
        arg0.value = arg0.value + 1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, v0);
        let v2 = HypedSui{
            hype_id   : 0x2::object::uid_to_inner(&arg0.id),
            owner     : 0x2::tx_context::sender(arg3),
            sui       : v1,
            tokenType : arg0.tokenType,
            value     : arg0.value,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<HypedSui>(v2);
    }

    public fun with_token<T0>(arg0: &mut Hype<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        assert!(v1 >= arg0.min_token_amount, 1);
        arg0.value = arg0.value + 1;
        0x2::balance::join<T0>(&mut arg0.token, v0);
        let v2 = HypedToken{
            hype_id   : 0x2::object::uid_to_inner(&arg0.id),
            owner     : 0x2::tx_context::sender(arg3),
            token     : v1,
            tokenType : arg0.tokenType,
            value     : arg0.value,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<HypedToken>(v2);
    }

    public fun withdraw<T0>(arg0: &mut Hype<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        let v0 = sui_balance<T0>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui, v0, arg2), arg0.owner);
        let v1 = token_balance<T0>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.token, v1, arg2), arg0.owner);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg1);
        let v2 = WithdrawHype{
            hype_id   : 0x2::object::uid_to_inner(&arg0.id),
            owner     : 0x2::tx_context::sender(arg2),
            sui       : v0,
            token     : v1,
            tokenType : arg0.tokenType,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<WithdrawHype>(v2);
    }

    // decompiled from Move bytecode v6
}

