module 0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::bounty {
    struct BountyPool has key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        mode: u8,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct BountyCreated has copy, drop {
        pool_id: 0x2::object::ID,
        form_id: 0x2::object::ID,
        mode: u8,
        initial_amount: u64,
    }

    struct BountyTopUp has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct BountyPayout has copy, drop {
        pool_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    struct BountyClosed has copy, drop {
        pool_id: 0x2::object::ID,
        refunded: u64,
    }

    public fun add_funds(arg0: &mut BountyPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.funds, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = BountyTopUp{
            pool_id : 0x2::object::id<BountyPool>(arg0),
            amount  : 0x2::coin::value<0x2::sui::SUI>(&arg1),
        };
        0x2::event::emit<BountyTopUp>(v0);
    }

    public fun close_bounty(arg0: &0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::form::FormOwnerCap, arg1: BountyPool, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::form::cap_form_id(arg0) == arg1.form_id, 200);
        let BountyPool {
            id      : v0,
            form_id : _,
            mode    : _,
            funds   : v3,
        } = arg1;
        let v4 = v3;
        let v5 = v0;
        let v6 = BountyClosed{
            pool_id  : 0x2::object::uid_to_inner(&v5),
            refunded : 0x2::balance::value<0x2::sui::SUI>(&v4),
        };
        0x2::event::emit<BountyClosed>(v6);
        0x2::object::delete(v5);
        0x2::coin::from_balance<0x2::sui::SUI>(v4, arg2)
    }

    public fun create_bounty(arg0: &0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::form::FormOwnerCap, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = BountyPool{
            id      : 0x2::object::new(arg3),
            form_id : 0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::form::cap_form_id(arg0),
            mode    : arg2,
            funds   : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
        };
        let v1 = BountyCreated{
            pool_id        : 0x2::object::id<BountyPool>(&v0),
            form_id        : v0.form_id,
            mode           : arg2,
            initial_amount : 0x2::coin::value<0x2::sui::SUI>(&arg1),
        };
        0x2::event::emit<BountyCreated>(v1);
        0x2::transfer::share_object<BountyPool>(v0);
    }

    public fun mode_admin_select() : u8 {
        0
    }

    public fun mode_quadratic() : u8 {
        2
    }

    public fun mode_top_k() : u8 {
        1
    }

    public fun payout_to(arg0: &0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::form::FormOwnerCap, arg1: &mut BountyPool, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::form::cap_form_id(arg0) == arg1.form_id, 200);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.funds) >= arg3, 201);
        let v0 = BountyPayout{
            pool_id   : 0x2::object::id<BountyPool>(arg1),
            recipient : arg2,
            amount    : arg3,
        };
        0x2::event::emit<BountyPayout>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.funds, arg3), arg4), arg2);
    }

    public fun pool_balance(arg0: &BountyPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.funds)
    }

    public fun pool_form_id(arg0: &BountyPool) : 0x2::object::ID {
        arg0.form_id
    }

    public fun pool_mode(arg0: &BountyPool) : u8 {
        arg0.mode
    }

    // decompiled from Move bytecode v6
}

