module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight_rewards {
    struct BossVictory has drop {
        dummy_field: bool,
    }

    struct FightRewards has copy, drop, store {
        weight: u64,
        paid: 0x1::option::Option<u64>,
    }

    public(friend) fun add_mob(arg0: &mut FightRewards, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::mob_rows::MobTemplate, arg2: &0x3cdc9a4c163c10ef3973e3cf58d8c76999a98f729e06247a8d5fe16792302164::combat::Fighter) {
        if (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_data::is_boss(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::mob_rows::data(arg1))) {
            arg0.weight = arg0.weight + 0x3cdc9a4c163c10ef3973e3cf58d8c76999a98f729e06247a8d5fe16792302164::combat::level(arg2);
        };
    }

    public(friend) fun allocate(arg0: &mut FightRewards, arg1: &0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::offering::Offering, arg2: &mut 0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::combat_rewards::CombatPot, arg3: vector<address>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg0.weight == 0 || 0x1::option::is_some<u64>(&arg0.paid)) {
            return
        };
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 > 0, 0);
        let v1 = BossVictory{dummy_field: false};
        let v2 = 0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::offering::boss_bounty<BossVictory>(arg1, arg2, v1, arg0.weight, v0, arg4, arg5);
        let v3 = 0x2::balance::value<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&v2) / v0;
        arg0.paid = 0x1::option::some<u64>(v3);
        if (v3 > 0) {
            let v4 = 0;
            while (v4 < v0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>>(0x2::coin::from_balance<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(0x2::balance::split<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&mut v2, v3), arg5), *0x1::vector::borrow<address>(&arg3, v4));
                v4 = v4 + 1;
            };
        };
        0x2::balance::destroy_zero<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(v2);
    }

    public(friend) fun amount(arg0: &FightRewards) : u64 {
        0x1::option::get_with_default<u64>(&arg0.paid, 0)
    }

    public(friend) fun new() : FightRewards {
        FightRewards{
            weight : 0,
            paid   : 0x1::option::none<u64>(),
        }
    }

    public(friend) fun ready(arg0: &FightRewards) : bool {
        arg0.weight == 0 || 0x1::option::is_some<u64>(&arg0.paid)
    }

    // decompiled from Move bytecode v7
}

