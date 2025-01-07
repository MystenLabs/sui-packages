module 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::burner {
    struct BurnerRole has drop {
        dummy_field: bool,
    }

    struct BurnRecipient has key {
        id: 0x2::object::UID,
    }

    struct BurnEvent<phantom T0> has copy, drop {
        amount: u64,
        recipient: address,
    }

    public fun burn<T0>(arg0: &mut 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::ManagedTreasury<T0>, arg1: &mut BurnRecipient, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::assert_is_authorized<BurnerRole>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles<T0>(arg0), 0x2::tx_context::sender(arg3));
        0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::assert_is_not_paused<BurnerRole>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles<T0>(arg0));
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg1.id, arg2);
        let v1 = 0x2::object::id<BurnRecipient>(arg1);
        let v2 = BurnEvent<T0>{
            amount    : 0x2::coin::value<T0>(&v0),
            recipient : 0x2::object::id_to_address(&v1),
        };
        0x2::event::emit<BurnEvent<T0>>(v2);
        0x2::coin::burn<T0>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::treasury_cap_mut<T0>(arg0), v0);
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BurnRecipient{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<BurnRecipient>(v0);
    }

    // decompiled from Move bytecode v6
}

