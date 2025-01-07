module 0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::nft_farm {
    struct GatedFarm<phantom T0> has store, key {
        id: 0x2::object::UID,
        level: u8,
        farm: 0x4c9bf061d3fb029d673b6f71e5993027a61cfe963ab0abe2cb97f8595093497d::farm::Farm<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit, T0>,
    }

    public fun add_rewards<T0>(arg0: &mut GatedFarm<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>) {
        0x4c9bf061d3fb029d673b6f71e5993027a61cfe963ab0abe2cb97f8595093497d::farm::add_rewards<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit, T0>(&mut arg0.farm, arg1, arg2);
    }

    public fun borrow_farm<T0>(arg0: &GatedFarm<T0>) : &0x4c9bf061d3fb029d673b6f71e5993027a61cfe963ab0abe2cb97f8595093497d::farm::Farm<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit, T0> {
        &arg0.farm
    }

    public fun destroy_zero_farm<T0>(arg0: GatedFarm<T0>, arg1: &0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::owner::OwnerCap<0x4c9bf061d3fb029d673b6f71e5993027a61cfe963ab0abe2cb97f8595093497d::farm::FarmWitness>) {
        let GatedFarm {
            id    : v0,
            level : _,
            farm  : v2,
        } = arg0;
        0x4c9bf061d3fb029d673b6f71e5993027a61cfe963ab0abe2cb97f8595093497d::farm::destroy_zero_farm<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit, T0>(v2, arg1);
        0x2::object::delete(v0);
    }

    public fun new_farm<T0>(arg0: 0x4c9bf061d3fb029d673b6f71e5993027a61cfe963ab0abe2cb97f8595093497d::farm::Farm<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit, T0>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : GatedFarm<T0> {
        GatedFarm<T0>{
            id    : 0x2::object::new(arg2),
            level : arg1,
            farm  : arg0,
        }
    }

    public fun pending_rewards<T0>(arg0: &GatedFarm<T0>, arg1: &0x4c9bf061d3fb029d673b6f71e5993027a61cfe963ab0abe2cb97f8595093497d::farm::Account<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit, T0>, arg2: &0x2::clock::Clock) : u64 {
        0x4c9bf061d3fb029d673b6f71e5993027a61cfe963ab0abe2cb97f8595093497d::farm::pending_rewards<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit, T0>(&arg0.farm, arg1, arg2)
    }

    public fun remove_rewards<T0>(arg0: &0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::owner::OwnerCap<0x4c9bf061d3fb029d673b6f71e5993027a61cfe963ab0abe2cb97f8595093497d::farm::FarmWitness>, arg1: &mut GatedFarm<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x4c9bf061d3fb029d673b6f71e5993027a61cfe963ab0abe2cb97f8595093497d::farm::remove_rewards<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit, T0>(arg0, &mut arg1.farm, arg2, arg3, arg4)
    }

    public fun share_farm<T0>(arg0: GatedFarm<T0>) {
        0x2::transfer::public_share_object<GatedFarm<T0>>(arg0);
    }

    public fun stake<T0>(arg0: &mut GatedFarm<T0>, arg1: &mut 0x4c9bf061d3fb029d673b6f71e5993027a61cfe963ab0abe2cb97f8595093497d::farm::Account<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit, T0>, arg2: &0x2::transfer_policy::TransferPolicy<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit>, arg3: &mut 0x2::kiosk::Kiosk, arg4: 0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::level(&arg4) == arg0.level, 9223372311732682751);
        0x4c9bf061d3fb029d673b6f71e5993027a61cfe963ab0abe2cb97f8595093497d::farm::stake<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit, T0>(&mut arg0.farm, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun stake_kiosk<T0>(arg0: &mut GatedFarm<T0>, arg1: &mut 0x4c9bf061d3fb029d673b6f71e5993027a61cfe963ab0abe2cb97f8595093497d::farm::Account<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit, T0>, arg2: &0x2::transfer_policy::TransferPolicy<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit>, arg3: &mut 0x2::kiosk::Kiosk, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::transfer_policy::TransferRequest<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit>) {
        0x2::kiosk::list<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit>(arg5, arg6, arg4, 0);
        let (v0, v1) = 0x2::kiosk::purchase<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit>(arg5, arg4, 0x2::coin::zero<0x2::sui::SUI>(arg8));
        (stake<T0>(arg0, arg1, arg2, arg3, v0, arg7, arg8), v1)
    }

    public fun stake_personal_kiosk<T0>(arg0: &mut GatedFarm<T0>, arg1: &mut 0x4c9bf061d3fb029d673b6f71e5993027a61cfe963ab0abe2cb97f8595093497d::farm::Account<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit, T0>, arg2: &0x2::transfer_policy::TransferPolicy<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit>, arg3: &mut 0x2::kiosk::Kiosk, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::transfer_policy::TransferRequest<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit>) {
        0x2::kiosk::list<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit>(arg5, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg6), arg4, 0);
        let (v0, v1) = 0x2::kiosk::purchase<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit>(arg5, arg4, 0x2::coin::zero<0x2::sui::SUI>(arg8));
        (stake<T0>(arg0, arg1, arg2, arg3, v0, arg7, arg8), v1)
    }

    public fun unstake<T0>(arg0: &mut GatedFarm<T0>, arg1: &mut 0x4c9bf061d3fb029d673b6f71e5993027a61cfe963ab0abe2cb97f8595093497d::farm::Account<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit, T0>, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit, 0x2::transfer_policy::TransferRequest<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit>) {
        0x4c9bf061d3fb029d673b6f71e5993027a61cfe963ab0abe2cb97f8595093497d::farm::unstake<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit, T0>(&mut arg0.farm, arg1, arg2, arg3, arg4, arg5)
    }

    public fun update_rewards_per_second<T0>(arg0: &mut GatedFarm<T0>, arg1: &0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::owner::OwnerCap<0x4c9bf061d3fb029d673b6f71e5993027a61cfe963ab0abe2cb97f8595093497d::farm::FarmWitness>, arg2: u64, arg3: &0x2::clock::Clock) {
        0x4c9bf061d3fb029d673b6f71e5993027a61cfe963ab0abe2cb97f8595093497d::farm::update_rewards_per_second<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit, T0>(&mut arg0.farm, arg1, arg2, arg3);
    }

    public fun withdraw_rewards<T0>(arg0: &mut GatedFarm<T0>, arg1: &mut 0x4c9bf061d3fb029d673b6f71e5993027a61cfe963ab0abe2cb97f8595093497d::farm::Account<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit, T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x4c9bf061d3fb029d673b6f71e5993027a61cfe963ab0abe2cb97f8595093497d::farm::withdraw_rewards<0x438669016a80cc7d4736323fc2d0dc6c4ed32b7b183a17cc467e97f1175d06e9::collection::DegenRabbit, T0>(&mut arg0.farm, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

