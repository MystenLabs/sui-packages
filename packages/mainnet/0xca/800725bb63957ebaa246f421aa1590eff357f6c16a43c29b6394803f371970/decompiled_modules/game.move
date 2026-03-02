module 0xca800725bb63957ebaa246f421aa1590eff357f6c16a43c29b6394803f371970::game {
    struct FlipResult has copy, drop {
        player: address,
        bet_amount: u64,
        guess: bool,
        outcome: bool,
        won: bool,
        payout: u64,
    }

    struct House<phantom T0> has key {
        id: 0x2::object::UID,
        vault: 0x2::balance::Balance<T0>,
        owner: address,
    }

    struct HouseOwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        house_id: 0x2::object::ID,
    }

    public fun fund<T0>(arg0: &mut House<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun init_house<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : HouseOwnerCap<T0> {
        let v0 = 0x2::object::new(arg1);
        let v1 = House<T0>{
            id    : v0,
            vault : 0x2::coin::into_balance<T0>(arg0),
            owner : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<House<T0>>(v1);
        HouseOwnerCap<T0>{
            id       : 0x2::object::new(arg1),
            house_id : 0x2::object::uid_to_inner(&v0),
        }
    }

    entry fun play<T0>(arg0: &mut House<T0>, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        assert!(0x2::balance::value<T0>(&arg0.vault) >= v0, 1);
        let v1 = 0x2::random::new_generator(arg3, arg4);
        let v2 = 0x2::random::generate_u8_in_range(&mut v1, 0, 1) == 1;
        if (arg2 == v2) {
            0x2::coin::join<T0>(&mut arg1, 0x2::coin::take<T0>(&mut arg0.vault, v0, arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
            let v3 = FlipResult{
                player     : 0x2::tx_context::sender(arg4),
                bet_amount : v0,
                guess      : arg2,
                outcome    : v2,
                won        : true,
                payout     : v0 * 2,
            };
            0x2::event::emit<FlipResult>(v3);
        } else {
            0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg1));
            let v4 = FlipResult{
                player     : 0x2::tx_context::sender(arg4),
                bet_amount : v0,
                guess      : arg2,
                outcome    : v2,
                won        : false,
                payout     : 0,
            };
            0x2::event::emit<FlipResult>(v4);
        };
    }

    public fun vault_balance<T0>(arg0: &House<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.vault)
    }

    public fun withdraw<T0>(arg0: &mut House<T0>, arg1: &HouseOwnerCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg0.vault) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.vault, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

