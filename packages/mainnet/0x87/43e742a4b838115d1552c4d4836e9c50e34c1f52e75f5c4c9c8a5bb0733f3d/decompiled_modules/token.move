module 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::token {
    struct TokenMint<T0: copy + drop> has copy, drop {
        token: address,
        recipient: address,
        amount: u64,
        ctx: T0,
    }

    struct TokenTransfer<T0: copy + drop> has copy, drop {
        token: address,
        sender: address,
        recipient: address,
        amount: u64,
        ctx: T0,
    }

    struct Collar has store, key {
        id: 0x2::object::UID,
        token: address,
        symbol: 0x1::string::String,
    }

    struct Token<phantom T0> has store, key {
        id: 0x2::object::UID,
        network: address,
        symbol: 0x1::string::String,
        owner: address,
        collar: address,
        ctrl: u64,
        treasury: address,
        meta: address,
        limit: u64,
        committee: 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::committee::Committee,
    }

    public fun mint<T0>(arg0: &Token<T0>, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.treasury == 0x2::object::id_address<0x2::coin::TreasuryCap<T0>>(arg1), 91100001);
        assert!(arg2 + 0x2::balance::supply_value<T0>(0x2::coin::supply<T0>(arg1)) <= arg0.limit, 91100002);
        0x2::coin::mint<T0>(arg1, arg2, arg3)
    }

    public fun committee_borrow<T0: copy + drop>(arg0: &Token<T0>) : &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::committee::Committee {
        &arg0.committee
    }

    public fun committee_borrow_mut<T0: copy + drop>(arg0: &mut Token<T0>) : &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::committee::Committee {
        &mut arg0.committee
    }

    public fun create_token<T0>(arg0: address, arg1: vector<u8>, arg2: address, arg3: 0x2::coin::TreasuryCap<T0>, arg4: 0x2::coin::CoinMetadata<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg6);
        let v1 = Token<T0>{
            id        : 0x2::object::new(arg6),
            network   : arg0,
            symbol    : 0x1::string::utf8(arg1),
            owner     : arg2,
            collar    : 0x2::object::uid_to_address(&v0),
            ctrl      : 0,
            treasury  : 0x2::object::id_address<0x2::coin::TreasuryCap<T0>>(&arg3),
            meta      : 0x2::object::id_address<0x2::coin::CoinMetadata<T0>>(&arg4),
            limit     : arg5,
            committee : 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::committee::new(arg6),
        };
        let v2 = 0x2::object::id_address<Token<T0>>(&v1);
        let v3 = Collar{
            id     : v0,
            token  : v2,
            symbol : 0x1::string::utf8(arg1),
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg3, arg2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<T0>>(arg4, arg2);
        0x2::transfer::public_transfer<Token<T0>>(v1, arg2);
        0x2::transfer::public_transfer<Collar>(v3, arg0);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::event::emit_token_born_event(v2);
    }

    public fun ctrl_borrow<T0: copy + drop>(arg0: &Token<T0>) : u64 {
        arg0.ctrl
    }

    public fun limit_borrow<T0: copy + drop>(arg0: &Token<T0>) : u64 {
        arg0.limit
    }

    public fun mint_transfer<T0, T1: copy + drop>(arg0: &Token<T0>, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: u64, arg3: address, arg4: u16, arg5: 0x1::string::String, arg6: T1, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(mint<T0>(arg0, arg1, arg2, arg7), arg3);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::event::emit<TokenMint<T1>>(arg4, arg5, new_mint_event<T1>(0x2::object::id_address<Token<T0>>(arg0), arg3, arg2, arg6));
    }

    public fun new_mint_event<T0: copy + drop>(arg0: address, arg1: address, arg2: u64, arg3: T0) : TokenMint<T0> {
        TokenMint<T0>{
            token     : arg0,
            recipient : arg1,
            amount    : arg2,
            ctx       : arg3,
        }
    }

    public fun new_transfer_event<T0: copy + drop>(arg0: address, arg1: address, arg2: address, arg3: u64, arg4: T0) : TokenTransfer<T0> {
        TokenTransfer<T0>{
            token     : arg0,
            sender    : arg1,
            recipient : arg2,
            amount    : arg3,
            ctx       : arg4,
        }
    }

    public fun owner_borrow<T0: copy + drop>(arg0: &Token<T0>) : address {
        arg0.owner
    }

    public fun set_ctrl<T0: copy + drop>(arg0: &mut Token<T0>, arg1: u64) {
        arg0.ctrl = arg1;
    }

    public fun set_limit<T0: copy + drop>(arg0: &mut Token<T0>, arg1: u64) {
        arg0.limit = arg1;
    }

    public fun set_owner<T0: copy + drop>(arg0: Token<T0>, arg1: address) {
        arg0.owner = arg1;
        0x2::transfer::public_transfer<Token<T0>>(arg0, arg1);
    }

    public fun set_symbol<T0: copy + drop>(arg0: &mut Token<T0>, arg1: 0x1::string::String) {
        arg0.symbol = arg1;
    }

    public fun symbol_borrow<T0: copy + drop>(arg0: &Token<T0>) : 0x1::string::String {
        arg0.symbol
    }

    // decompiled from Move bytecode v6
}

