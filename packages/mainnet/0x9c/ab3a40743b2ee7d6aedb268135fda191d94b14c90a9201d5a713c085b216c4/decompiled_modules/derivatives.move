module 0x9cab3a40743b2ee7d6aedb268135fda191d94b14c90a9201d5a713c085b216c4::derivatives {
    struct CallOption<T0: store + key> has store, key {
        id: 0x2::object::UID,
        underlying_asset: T0,
        seller: address,
        strike_price: u64,
        expiry: u64,
    }

    struct OptionCreated has copy, drop {
        id: 0x2::object::ID,
        seller: address,
        strike_price: u64,
        expiry: u64,
    }

    struct OptionExercised has copy, drop {
        id: 0x2::object::ID,
        buyer: address,
    }

    struct AssetReclaimed has copy, drop {
        id: 0x2::object::ID,
        seller: address,
    }

    public fun create_option<T0: store + key>(arg0: T0, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : CallOption<T0> {
        let v0 = 0x2::object::new(arg3);
        let v1 = OptionCreated{
            id           : 0x2::object::uid_to_inner(&v0),
            seller       : 0x2::tx_context::sender(arg3),
            strike_price : arg1,
            expiry       : arg2,
        };
        0x2::event::emit<OptionCreated>(v1);
        CallOption<T0>{
            id               : v0,
            underlying_asset : arg0,
            seller           : 0x2::tx_context::sender(arg3),
            strike_price     : arg1,
            expiry           : arg2,
        }
    }

    public fun exercise<T0: store + key>(arg0: CallOption<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        let CallOption {
            id               : v0,
            underlying_asset : v1,
            seller           : v2,
            strike_price     : v3,
            expiry           : v4,
        } = arg0;
        let v5 = v0;
        assert!(0x2::clock::timestamp_ms(arg2) < v4, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == v3, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v2);
        let v6 = OptionExercised{
            id    : 0x2::object::uid_to_inner(&v5),
            buyer : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<OptionExercised>(v6);
        0x2::object::delete(v5);
        v1
    }

    public fun reclaim_asset<T0: store + key>(arg0: CallOption<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let CallOption {
            id               : v0,
            underlying_asset : v1,
            seller           : v2,
            strike_price     : _,
            expiry           : v4,
        } = arg0;
        let v5 = v0;
        assert!(0x2::clock::timestamp_ms(arg1) >= v4, 1);
        let v6 = AssetReclaimed{
            id     : 0x2::object::uid_to_inner(&v5),
            seller : v2,
        };
        0x2::event::emit<AssetReclaimed>(v6);
        0x2::object::delete(v5);
        v1
    }

    // decompiled from Move bytecode v6
}

