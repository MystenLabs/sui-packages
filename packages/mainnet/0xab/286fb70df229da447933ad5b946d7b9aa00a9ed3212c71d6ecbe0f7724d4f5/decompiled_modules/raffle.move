module 0x862810efecf0296db2e9df3e075a7af8034ba374e73ff1098e88cc4bb7c15437::raffle {
    struct RaffleRegistry has store, key {
        id: 0x2::object::UID,
        citizens_odds_mapping: 0x2::table::Table<u64, 0x2::object::ID>,
        citizen_chances: 0x2::table::Table<0x2::object::ID, u64>,
        total_citizen_chances: u64,
    }

    struct CitizenWonItemEvent<phantom T0> has copy, drop {
        citizen_winner: 0x2::object::ID,
    }

    struct CitizenWonCoinEvent<phantom T0> has copy, drop {
        amount: u64,
        citizen_winner: 0x2::object::ID,
    }

    public fun add_citizen_changes(arg0: &0x862810efecf0296db2e9df3e075a7af8034ba374e73ff1098e88cc4bb7c15437::admin::CitizenCap, arg1: &mut RaffleRegistry, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = arg1.total_citizen_chances + 1;
        while (v0 < arg1.total_citizen_chances + arg3) {
            0x2::table::add<u64, 0x2::object::ID>(&mut arg1.citizens_odds_mapping, v0, arg2);
            v0 = v0 + 1;
        };
        arg1.total_citizen_chances = arg1.total_citizen_chances + arg3;
        if (0x2::table::contains<0x2::object::ID, u64>(&arg1.citizen_chances, arg2)) {
            0x2::table::add<0x2::object::ID, u64>(&mut arg1.citizen_chances, arg2, 0x2::table::remove<0x2::object::ID, u64>(&mut arg1.citizen_chances, arg2) + arg3);
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg1.citizen_chances, arg2, arg3);
        };
    }

    public fun get_citizen_odds(arg0: &RaffleRegistry, arg1: 0x2::object::ID) : u64 {
        *0x2::table::borrow<0x2::object::ID, u64>(&arg0.citizen_chances, arg1)
    }

    public fun new_registry(arg0: &0x862810efecf0296db2e9df3e075a7af8034ba374e73ff1098e88cc4bb7c15437::admin::CitizenCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RaffleRegistry{
            id                    : 0x2::object::new(arg1),
            citizens_odds_mapping : 0x2::table::new<u64, 0x2::object::ID>(arg1),
            citizen_chances       : 0x2::table::new<0x2::object::ID, u64>(arg1),
            total_citizen_chances : 0,
        };
        0x2::transfer::public_share_object<RaffleRegistry>(v0);
    }

    entry fun raffle_coin_to_citizen<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &RaffleRegistry, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = 0x2::random::generate_u64_in_range(&mut v0, 1, arg1.total_citizen_chances);
        while (!0x2::table::contains<u64, 0x2::object::ID>(&arg1.citizens_odds_mapping, v1)) {
            v1 = 0x2::random::generate_u64_in_range(&mut v0, 1, arg1.total_citizen_chances);
        };
        let v2 = *0x2::table::borrow<u64, 0x2::object::ID>(&arg1.citizens_odds_mapping, v1);
        let v3 = CitizenWonCoinEvent<T0>{
            amount         : 0x2::coin::value<T0>(&arg0),
            citizen_winner : v2,
        };
        0x2::event::emit<CitizenWonCoinEvent<T0>>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::object::id_to_address(&v2));
    }

    entry fun raffle_item_to_citizen<T0: store + key>(arg0: T0, arg1: &RaffleRegistry, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = 0x2::random::generate_u64_in_range(&mut v0, 1, arg1.total_citizen_chances);
        while (!0x2::table::contains<u64, 0x2::object::ID>(&arg1.citizens_odds_mapping, v1)) {
            v1 = 0x2::random::generate_u64_in_range(&mut v0, 1, arg1.total_citizen_chances);
        };
        let v2 = *0x2::table::borrow<u64, 0x2::object::ID>(&arg1.citizens_odds_mapping, v1);
        let v3 = CitizenWonItemEvent<T0>{citizen_winner: v2};
        0x2::event::emit<CitizenWonItemEvent<T0>>(v3);
        0x2::transfer::public_transfer<T0>(arg0, 0x2::object::id_to_address(&v2));
    }

    public fun remove_chance(arg0: &0x862810efecf0296db2e9df3e075a7af8034ba374e73ff1098e88cc4bb7c15437::admin::CitizenCap, arg1: &mut RaffleRegistry, arg2: u64) {
        assert!(0x2::table::contains<u64, 0x2::object::ID>(&arg1.citizens_odds_mapping, arg2), 9223372328912551935);
        let v0 = 0x2::table::remove<u64, 0x2::object::ID>(&mut arg1.citizens_odds_mapping, arg2);
        0x2::table::add<0x2::object::ID, u64>(&mut arg1.citizen_chances, v0, 0x2::table::remove<0x2::object::ID, u64>(&mut arg1.citizen_chances, v0) - 1);
    }

    // decompiled from Move bytecode v6
}

