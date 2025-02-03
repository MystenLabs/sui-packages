module 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::yt {
    struct YTCoin<phantom T0> has drop {
        dummy_field: bool,
    }

    struct YTStruct<phantom T0> has store, key {
        id: 0x2::object::UID,
        expiry: u64,
        decimals: u8,
        symbol: vector<u8>,
        name: vector<u8>,
        supply: 0x2::balance::Supply<YTCoin<T0>>,
    }

    struct CreationEvent<phantom T0> has copy, drop {
        ytId: 0x2::object::ID,
        name: vector<u8>,
        symbol: vector<u8>,
        decimals: u8,
        expiry: u64,
    }

    struct MintEvent<phantom T0> has copy, drop {
        ytId: 0x2::object::ID,
        receiver: address,
        amount: u64,
    }

    struct BurnEvent<phantom T0> has copy, drop {
        ytId: 0x2::object::ID,
        amount: u64,
    }

    public(friend) fun burn<T0>(arg0: &mut YTStruct<T0>, arg1: 0x2::balance::Balance<YTCoin<T0>>) {
        let v0 = BurnEvent<T0>{
            ytId   : 0x2::object::uid_to_inner(&arg0.id),
            amount : 0x2::balance::decrease_supply<YTCoin<T0>>(&mut arg0.supply, arg1),
        };
        0x2::event::emit<BurnEvent<T0>>(v0);
    }

    public(friend) fun create<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = YTCoin<T0>{dummy_field: false};
        let v1 = YTStruct<T0>{
            id       : 0x2::object::new(arg4),
            expiry   : arg3,
            decimals : arg2,
            symbol   : arg1,
            name     : arg0,
            supply   : 0x2::balance::create_supply<YTCoin<T0>>(v0),
        };
        let v2 = CreationEvent<T0>{
            ytId     : 0x2::object::uid_to_inner(&v1.id),
            name     : arg0,
            symbol   : arg1,
            decimals : arg2,
            expiry   : arg3,
        };
        0x2::event::emit<CreationEvent<T0>>(v2);
        0x2::transfer::share_object<YTStruct<T0>>(v1);
    }

    public fun expiry<T0>(arg0: &YTStruct<T0>) : u64 {
        arg0.expiry
    }

    public(friend) fun mint<T0>(arg0: &mut YTStruct<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<YTCoin<T0>> {
        let v0 = MintEvent<T0>{
            ytId     : 0x2::object::uid_to_inner(&arg0.id),
            receiver : arg1,
            amount   : arg2,
        };
        0x2::event::emit<MintEvent<T0>>(v0);
        0x2::coin::from_balance<YTCoin<T0>>(0x2::balance::increase_supply<YTCoin<T0>>(&mut arg0.supply, arg2), arg3)
    }

    public fun totalSupply<T0>(arg0: &YTStruct<T0>) : u64 {
        0x2::balance::supply_value<YTCoin<T0>>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

