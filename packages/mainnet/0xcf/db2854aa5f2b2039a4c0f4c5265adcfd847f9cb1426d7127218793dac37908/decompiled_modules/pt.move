module 0xcfdb2854aa5f2b2039a4c0f4c5265adcfd847f9cb1426d7127218793dac37908::pt {
    struct PTCoin<phantom T0> has drop {
        dummy_field: bool,
    }

    struct PTStruct<phantom T0> has store, key {
        id: 0x2::object::UID,
        expiry: u64,
        decimals: u8,
        symbol: vector<u8>,
        name: vector<u8>,
        supply: 0x2::balance::Supply<PTCoin<T0>>,
    }

    struct CreationEvent<phantom T0> has copy, drop {
        ptId: 0x2::object::ID,
        name: vector<u8>,
        symbol: vector<u8>,
        decimals: u8,
        expiry: u64,
    }

    struct MintEvent<phantom T0> has copy, drop {
        ptId: 0x2::object::ID,
        receiver: address,
        amount: u64,
    }

    struct BurnEvent<phantom T0> has copy, drop {
        ptId: 0x2::object::ID,
        amount: u64,
    }

    public(friend) fun burn<T0>(arg0: &mut PTStruct<T0>, arg1: 0x2::balance::Balance<PTCoin<T0>>) {
        let v0 = BurnEvent<T0>{
            ptId   : 0x2::object::uid_to_inner(&arg0.id),
            amount : 0x2::balance::decrease_supply<PTCoin<T0>>(&mut arg0.supply, arg1),
        };
        0x2::event::emit<BurnEvent<T0>>(v0);
    }

    public(friend) fun create<T0: drop>(arg0: vector<u8>, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = PTCoin<T0>{dummy_field: false};
        let v1 = PTStruct<T0>{
            id       : 0x2::object::new(arg4),
            expiry   : arg3,
            decimals : arg2,
            symbol   : arg1,
            name     : arg0,
            supply   : 0x2::balance::create_supply<PTCoin<T0>>(v0),
        };
        let v2 = CreationEvent<T0>{
            ptId     : 0x2::object::uid_to_inner(&v1.id),
            name     : arg0,
            symbol   : arg1,
            decimals : arg2,
            expiry   : arg3,
        };
        0x2::event::emit<CreationEvent<T0>>(v2);
        0x2::transfer::share_object<PTStruct<T0>>(v1);
    }

    public fun expiry<T0>(arg0: &PTStruct<T0>) : u64 {
        arg0.expiry
    }

    public(friend) fun mint<T0>(arg0: &mut PTStruct<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PTCoin<T0>> {
        let v0 = MintEvent<T0>{
            ptId     : 0x2::object::uid_to_inner(&arg0.id),
            receiver : arg1,
            amount   : arg2,
        };
        0x2::event::emit<MintEvent<T0>>(v0);
        0x2::coin::from_balance<PTCoin<T0>>(0x2::balance::increase_supply<PTCoin<T0>>(&mut arg0.supply, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

