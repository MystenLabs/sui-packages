module 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonsai {
    struct BONSAI has drop {
        dummy_field: bool,
    }

    struct Bonsai has store, key {
        id: 0x2::object::UID,
        level: u64,
        power: u64,
        max_power: u64,
        generation: u64,
        breed_count: u64,
        rarity: u8,
        variation: u64,
        serial: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        age: u64,
        born_at_ms: u64,
        bonexp_synced_at_ms: u64,
        breed_ready_at_ms: u64,
        attack_ready_at_ms: u64,
        last_drained_by: address,
    }

    struct Arena has key {
        id: 0x2::object::UID,
        entries: 0x2::table::Table<0x2::object::ID, ArenaEntry>,
        stationed: u64,
        stationed_counts: 0x2::vec_map::VecMap<address, u64>,
    }

    struct ArenaEntry has store {
        owner: address,
        immune_until_ms: u64,
        stationed_at_epoch: u64,
        unbanked: 0x2::balance::Balance<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>,
    }

    struct MintEvent has copy, drop {
        bonsai_id: 0x2::object::ID,
        owner: address,
        generation: u64,
    }

    struct ReservedMintEvent has copy, drop {
        bonsai_id: 0x2::object::ID,
        owner: address,
        rarity: u8,
    }

    struct BreedEvent has copy, drop {
        child_id: 0x2::object::ID,
        parent1: 0x2::object::ID,
        parent2: 0x2::object::ID,
        generation: u64,
        owner: address,
    }

    struct DrainEvent has copy, drop {
        attacker: 0x2::object::ID,
        target: 0x2::object::ID,
        attacker_owner: address,
        target_owner: address,
        siphoned: u64,
        absorbed: u64,
        timestamp_ms: u64,
    }

    struct HarvestEvent has copy, drop {
        bonsai_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct WaterEvent has copy, drop {
        bonsai_id: 0x2::object::ID,
        owner: address,
        paid_with_bonexp: bool,
    }

    public fun age(arg0: &Bonsai) : u64 {
        arg0.age
    }

    fun age_bonus_bps(arg0: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::Config, arg1: u64) : u64 {
        let v0 = arg1 * 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::age_bonus_bps(arg0);
        let v1 = 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::max_age_bonus_bps(arg0);
        if (v0 > v1) {
            v1
        } else {
            v0
        }
    }

    fun apply_water(arg0: &mut Arena, arg1: &mut 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BonexpVault, arg2: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::Config, arg3: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, ArenaEntry>(&arg0.entries, arg4), 1);
        assert!(0x2::table::borrow<0x2::object::ID, ArenaEntry>(&arg0.entries, arg4).owner == 0x2::tx_context::sender(arg6), 2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, ArenaEntry>(&mut arg0.entries, arg4);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Bonsai>(&mut arg0.id, arg4);
        assert!(v1.power < v1.max_power, 9);
        settle_bonexp(v0, v1, arg1, arg2, 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::epoch(arg3), 0x2::clock::timestamp_ms(arg5));
        v1.power = v1.max_power;
    }

    public fun attack_ready_at_ms(arg0: &Bonsai) : u64 {
        arg0.attack_ready_at_ms
    }

    public fun attributes(arg0: &Bonsai) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun bonexp_synced_at_ms(arg0: &Bonsai) : u64 {
        arg0.bonexp_synced_at_ms
    }

    public fun born_at_ms(arg0: &Bonsai) : u64 {
        arg0.born_at_ms
    }

    entry fun breed(arg0: &mut 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::GameBank, arg1: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::Config, arg2: &mut 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BonexpVault, arg3: &mut Bonsai, arg4: &mut Bonsai, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x2::coin::Coin<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>, arg7: &0x2::random::Random, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::assert_version(arg1);
        assert!(!0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::paused(arg1), 10);
        assert!(0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::total_minted(arg0) < 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::total_supply_cap(arg1), 8);
        assert!(0x2::object::id<Bonsai>(arg3) != 0x2::object::id<Bonsai>(arg4), 6);
        assert!(arg3.breed_count < 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::max_breed_count(arg1), 11);
        assert!(arg4.breed_count < 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::max_breed_count(arg1), 11);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert!(v0 >= arg3.breed_ready_at_ms, 7);
        assert!(v0 >= arg4.breed_ready_at_ms, 7);
        let v1 = 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::breed_base_price(arg1);
        collect(arg0, arg5, v1 + mul_bps(v1, (arg3.breed_count + arg4.breed_count) * 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::breed_escalation_bps(arg1)), 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::breed_dev_bps(arg1), arg9);
        let v2 = 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::breed_price_bonexp(arg1);
        assert!(0x2::coin::value<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(&arg6) >= v2, 0);
        if (0x2::coin::value<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(&arg6) == 0) {
            0x2::coin::destroy_zero<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(arg6);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>>(arg6, 0x2::tx_context::sender(arg9));
        };
        0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::burn(arg2, 0x2::coin::split<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(&mut arg6, v2, arg9));
        let v3 = 0x2::random::new_generator(arg7, arg9);
        let v4 = 100 + (arg3.max_power + arg4.max_power) / 8 + 0x2::random::generate_u64_in_range(&mut v3, 0, 20);
        let v5 = rarity_for_roll(0x2::random::generate_u64_in_range(&mut v3, 0, 9999), 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::breed_rarity_cutoffs(arg1));
        let v6 = 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::next_variation(arg0, arg1, v5);
        let v7 = if (arg3.generation > arg4.generation) {
            arg3.generation
        } else {
            arg4.generation
        };
        let v8 = v7 + 1;
        let v9 = Bonsai{
            id                  : 0x2::object::new(arg9),
            level               : 1,
            power               : v4,
            max_power           : v4,
            generation          : v8,
            breed_count         : 0,
            rarity              : v5,
            variation           : v6,
            serial              : 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::total_minted(arg0) + 1,
            attributes          : build_attributes(v5, v6, v4, v8, 0),
            age                 : 0,
            born_at_ms          : v0,
            bonexp_synced_at_ms : v0,
            breed_ready_at_ms   : v0,
            attack_ready_at_ms  : v0,
            last_drained_by     : @0x0,
        };
        arg3.breed_count = arg3.breed_count + 1;
        arg4.breed_count = arg4.breed_count + 1;
        let v10 = 0x1::string::utf8(b"Breed Count");
        *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg3.attributes, &v10) = 0x1::u64::to_string(arg3.breed_count);
        let v11 = 0x1::string::utf8(b"Breed Count");
        *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg4.attributes, &v11) = 0x1::u64::to_string(arg4.breed_count);
        arg3.breed_ready_at_ms = v0 + 86400000;
        arg4.breed_ready_at_ms = v0 + 86400000;
        0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::record_mint(arg0);
        let v12 = 0x2::tx_context::sender(arg9);
        let v13 = BreedEvent{
            child_id   : 0x2::object::id<Bonsai>(&v9),
            parent1    : 0x2::object::id<Bonsai>(arg3),
            parent2    : 0x2::object::id<Bonsai>(arg4),
            generation : v8,
            owner      : v12,
        };
        0x2::event::emit<BreedEvent>(v13);
        0x2::transfer::public_transfer<Bonsai>(v9, v12);
    }

    public fun breed_count(arg0: &Bonsai) : u64 {
        arg0.breed_count
    }

    public fun breed_ready_at_ms(arg0: &Bonsai) : u64 {
        arg0.breed_ready_at_ms
    }

    fun build_attributes(arg0: u8, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Rarity"), 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonsai_attributes::rarity_name(arg0));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Tree"), 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonsai_attributes::tree_of(arg0, arg1));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Pot"), 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonsai_attributes::pot_of(arg0, arg1));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Face"), 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonsai_attributes::face_of(arg0, arg1));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Feet"), 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonsai_attributes::feet_of(arg0, arg1));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Max Vigour"), 0x1::u64::to_string(arg2));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Generation"), 0x1::u64::to_string(arg3));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Breed Count"), 0x1::u64::to_string(arg4));
        v0
    }

    fun collect(arg0: &mut 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::GameBank, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg2, 0);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg4));
        };
        0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::route(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg2, arg4)), arg3);
    }

    public fun drain(arg0: &mut Arena, arg1: &mut 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BonexpVault, arg2: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::Config, arg3: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::assert_version(arg2);
        assert!(!0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::paused(arg2), 10);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::epoch(arg3);
        let v2 = 0x2::tx_context::sender(arg7);
        assert!(arg4 != arg5, 3);
        assert!(0x2::table::contains<0x2::object::ID, ArenaEntry>(&arg0.entries, arg4), 1);
        assert!(0x2::table::contains<0x2::object::ID, ArenaEntry>(&arg0.entries, arg5), 1);
        assert!(0x2::table::borrow<0x2::object::ID, ArenaEntry>(&arg0.entries, arg4).owner == v2, 2);
        let v3 = 0x2::table::borrow<0x2::object::ID, ArenaEntry>(&arg0.entries, arg5).owner;
        assert!(v3 != v2, 3);
        assert!(v0 >= 0x2::dynamic_object_field::borrow<0x2::object::ID, Bonsai>(&arg0.id, arg4).attack_ready_at_ms, 4);
        assert!(v0 >= 0x2::table::borrow<0x2::object::ID, ArenaEntry>(&arg0.entries, arg5).immune_until_ms, 5);
        let v4 = 0x2::table::borrow_mut<0x2::object::ID, ArenaEntry>(&mut arg0.entries, arg5);
        let v5 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Bonsai>(&mut arg0.id, arg5);
        settle_bonexp(v4, v5, arg1, arg2, v1, v0);
        let v6 = mul_bps(0x2::balance::value<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(&v4.unbanked), 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::drain_bps(arg2));
        v5.power = saturating_sub(v5.power, 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::drain_power_loss(arg2));
        v5.last_drained_by = v2;
        let v7 = 0x2::balance::split<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(&mut v4.unbanked, v6);
        let v8 = mul_bps(v6, 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::drain_efficiency_bps(arg2));
        if (0x2::balance::value<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(&v7) == 0) {
            0x2::balance::destroy_zero<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(v7);
        } else {
            0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::burn_balance(arg1, v7);
        };
        let v9 = 0x2::table::borrow_mut<0x2::object::ID, ArenaEntry>(&mut arg0.entries, arg4);
        let v10 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Bonsai>(&mut arg0.id, arg4);
        settle_bonexp(v9, v10, arg1, arg2, v1, v0);
        0x2::balance::join<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(&mut v9.unbanked, 0x2::balance::split<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(&mut v7, v8));
        v10.attack_ready_at_ms = v0 + 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::attack_cooldown_ms(arg2);
        0x2::table::borrow_mut<0x2::object::ID, ArenaEntry>(&mut arg0.entries, arg5).immune_until_ms = v0 + 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::defend_immunity_ms(arg2);
        let v11 = DrainEvent{
            attacker       : arg4,
            target         : arg5,
            attacker_owner : v2,
            target_owner   : v3,
            siphoned       : v6,
            absorbed       : v8,
            timestamp_ms   : v0,
        };
        0x2::event::emit<DrainEvent>(v11);
    }

    public fun enter_arena(arg0: &mut Arena, arg1: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard, arg2: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::Config, arg3: Bonsai, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::assert_version(arg2);
        let v0 = 0x2::object::id<Bonsai>(&arg3);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = if (0x2::vec_map::contains<address, u64>(&arg0.stationed_counts, &v1)) {
            *0x2::vec_map::get<address, u64>(&arg0.stationed_counts, &v1)
        } else {
            0
        };
        assert!(v2 < 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::max_stationed_per_owner(arg2), 12);
        arg3.bonexp_synced_at_ms = 0x2::clock::timestamp_ms(arg4);
        let v3 = ArenaEntry{
            owner              : v1,
            immune_until_ms    : 0,
            stationed_at_epoch : 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::epoch(arg1),
            unbanked           : 0x2::balance::zero<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(),
        };
        0x2::table::add<0x2::object::ID, ArenaEntry>(&mut arg0.entries, v0, v3);
        0x2::dynamic_object_field::add<0x2::object::ID, Bonsai>(&mut arg0.id, v0, arg3);
        arg0.stationed = arg0.stationed + 1;
        if (0x2::vec_map::contains<address, u64>(&arg0.stationed_counts, &v1)) {
            *0x2::vec_map::get_mut<address, u64>(&mut arg0.stationed_counts, &v1) = v2 + 1;
        } else {
            0x2::vec_map::insert<address, u64>(&mut arg0.stationed_counts, v1, 1);
        };
    }

    public fun entry_owner(arg0: &Arena, arg1: 0x2::object::ID) : address {
        0x2::table::borrow<0x2::object::ID, ArenaEntry>(&arg0.entries, arg1).owner
    }

    public fun exit_arena(arg0: &mut Arena, arg1: &mut 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BonexpVault, arg2: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::Config, arg3: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (Bonsai, 0x2::coin::Coin<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>) {
        0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::assert_version(arg2);
        assert!(0x2::table::contains<0x2::object::ID, ArenaEntry>(&arg0.entries, arg4), 1);
        assert!(0x2::table::borrow<0x2::object::ID, ArenaEntry>(&arg0.entries, arg4).owner == 0x2::tx_context::sender(arg6), 2);
        let v0 = 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::epoch(arg3);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, ArenaEntry>(&mut arg0.entries, arg4);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Bonsai>(&mut arg0.id, arg4);
        settle_bonexp(v1, v2, arg1, arg2, v0, 0x2::clock::timestamp_ms(arg5));
        let ArenaEntry {
            owner              : v3,
            immune_until_ms    : _,
            stationed_at_epoch : v5,
            unbanked           : v6,
        } = 0x2::table::remove<0x2::object::ID, ArenaEntry>(&mut arg0.entries, arg4);
        let v7 = v3;
        let v8 = 0x2::dynamic_object_field::remove<0x2::object::ID, Bonsai>(&mut arg0.id, arg4);
        v8.age = v8.age + v0 - v5;
        arg0.stationed = arg0.stationed - 1;
        let v9 = *0x2::vec_map::get<address, u64>(&arg0.stationed_counts, &v7) - 1;
        if (v9 == 0) {
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.stationed_counts, &v7);
        } else {
            *0x2::vec_map::get_mut<address, u64>(&mut arg0.stationed_counts, &v7) = v9;
        };
        (v8, 0x2::coin::from_balance<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(v6, arg6))
    }

    entry fun exit_arena_to_sender(arg0: &mut Arena, arg1: &mut 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BonexpVault, arg2: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::Config, arg3: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::assert_version(arg2);
        let (v0, v1) = exit_arena(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = v1;
        0x2::transfer::public_transfer<Bonsai>(v0, 0x2::tx_context::sender(arg6));
        if (0x2::coin::value<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(&v2) == 0) {
            0x2::coin::destroy_zero<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>>(v2, 0x2::tx_context::sender(arg6));
        };
    }

    public fun generation(arg0: &Bonsai) : u64 {
        arg0.generation
    }

    public fun harvest(arg0: &mut Arena, arg1: &mut 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BonexpVault, arg2: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::Config, arg3: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP> {
        0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::assert_version(arg2);
        assert!(0x2::table::contains<0x2::object::ID, ArenaEntry>(&arg0.entries, arg4), 1);
        assert!(0x2::table::borrow<0x2::object::ID, ArenaEntry>(&arg0.entries, arg4).owner == 0x2::tx_context::sender(arg6), 2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, ArenaEntry>(&mut arg0.entries, arg4);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Bonsai>(&mut arg0.id, arg4);
        settle_bonexp(v0, v1, arg1, arg2, 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::epoch(arg3), 0x2::clock::timestamp_ms(arg5));
        let v2 = 0x2::balance::value<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(&v0.unbanked);
        let v3 = HarvestEvent{
            bonsai_id : arg4,
            owner     : 0x2::tx_context::sender(arg6),
            amount    : v2,
        };
        0x2::event::emit<HarvestEvent>(v3);
        0x2::coin::from_balance<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(0x2::balance::split<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(&mut v0.unbanked, v2), arg6)
    }

    entry fun harvest_to_sender(arg0: &mut Arena, arg1: &mut 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BonexpVault, arg2: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::Config, arg3: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::assert_version(arg2);
        let v0 = harvest(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun immune_until_ms(arg0: &Arena, arg1: 0x2::object::ID) : u64 {
        0x2::table::borrow<0x2::object::ID, ArenaEntry>(&arg0.entries, arg1).immune_until_ms
    }

    fun init(arg0: BONSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<BONSAI>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"variation"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"age"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"breed_count"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Hash Bonsai #{serial}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Botanical code anchored on Sui. Water it, station it, or watch it bleed."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://hashbonsai-assets.wal.app/{rarity}_{variation}.png"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://hashbonsai.wal.app"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{rarity}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{variation}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{age}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{breed_count}"));
        let v5 = 0x2::display::new_with_fields<Bonsai>(&v0, v1, v3, arg1);
        0x2::display::update_version<Bonsai>(&mut v5);
        0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::setup_crown_seed_display(&v0, arg1);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v6);
        0x2::transfer::public_transfer<0x2::display::Display<Bonsai>>(v5, v6);
        let v7 = Arena{
            id               : 0x2::object::new(arg1),
            entries          : 0x2::table::new<0x2::object::ID, ArenaEntry>(arg1),
            stationed        : 0,
            stationed_counts : 0x2::vec_map::empty<address, u64>(),
        };
        0x2::transfer::share_object<Arena>(v7);
    }

    public fun last_drained_by(arg0: &Bonsai) : address {
        arg0.last_drained_by
    }

    public fun level(arg0: &Bonsai) : u64 {
        arg0.level
    }

    public fun max_power(arg0: &Bonsai) : u64 {
        arg0.max_power
    }

    fun mint(arg0: &mut 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::GameBank, arg1: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::Config, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Bonsai {
        let v0 = 0x2::random::new_generator(arg3, arg5);
        mint_with_rarity(arg0, arg1, arg2, rarity_for_roll(0x2::random::generate_u64_in_range(&mut v0, 0, 9999), 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::mint_rarity_cutoffs(arg1)), arg4, arg5)
    }

    entry fun mint_reserved(arg0: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::AdminCap, arg1: &mut 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::GameBank, arg2: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::Config, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::assert_version(arg2);
        assert!(0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::total_minted(arg1) < 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::initial_mint_cap(arg2), 8);
        let v0 = 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::next_variation(arg1, arg2, arg3);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = Bonsai{
            id                  : 0x2::object::new(arg5),
            level               : 1,
            power               : 100,
            max_power           : 100,
            generation          : 0,
            breed_count         : 0,
            rarity              : arg3,
            variation           : v0,
            serial              : 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::total_minted(arg1) + 1,
            attributes          : build_attributes(arg3, v0, 100, 0, 0),
            age                 : 0,
            born_at_ms          : v1,
            bonexp_synced_at_ms : v1,
            breed_ready_at_ms   : v1,
            attack_ready_at_ms  : v1,
            last_drained_by     : @0x0,
        };
        0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::record_mint(arg1);
        let v3 = ReservedMintEvent{
            bonsai_id : 0x2::object::id<Bonsai>(&v2),
            owner     : 0x2::tx_context::sender(arg5),
            rarity    : arg3,
        };
        0x2::event::emit<ReservedMintEvent>(v3);
        0x2::transfer::public_transfer<Bonsai>(v2, 0x2::tx_context::sender(arg5));
    }

    entry fun mint_to_sender(arg0: &mut 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::GameBank, arg1: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::Config, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::assert_version(arg1);
        let v0 = mint(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<Bonsai>(v0, 0x2::tx_context::sender(arg5));
    }

    fun mint_with_rarity(arg0: &mut 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::GameBank, arg1: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::Config, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Bonsai {
        assert!(!0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::paused(arg1), 10);
        assert!(0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::total_minted(arg0) < 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::initial_mint_cap(arg1), 8);
        collect(arg0, arg2, 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::mint_price(arg1), 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::mint_dev_bps(arg1), arg5);
        let v0 = 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::next_variation(arg0, arg1, arg3);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = Bonsai{
            id                  : 0x2::object::new(arg5),
            level               : 1,
            power               : 100,
            max_power           : 100,
            generation          : 0,
            breed_count         : 0,
            rarity              : arg3,
            variation           : v0,
            serial              : 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::total_minted(arg0) + 1,
            attributes          : build_attributes(arg3, v0, 100, 0, 0),
            age                 : 0,
            born_at_ms          : v1,
            bonexp_synced_at_ms : v1,
            breed_ready_at_ms   : v1,
            attack_ready_at_ms  : v1,
            last_drained_by     : @0x0,
        };
        0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::record_mint(arg0);
        let v3 = MintEvent{
            bonsai_id  : 0x2::object::id<Bonsai>(&v2),
            owner      : 0x2::tx_context::sender(arg5),
            generation : 0,
        };
        0x2::event::emit<MintEvent>(v3);
        v2
    }

    fun mul_bps(arg0: u64, arg1: u64) : u64 {
        mul_div(arg0, arg1, 10000)
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun power(arg0: &Bonsai) : u64 {
        arg0.power
    }

    public fun rarity(arg0: &Bonsai) : u8 {
        arg0.rarity
    }

    public fun rarity_common() : u8 {
        0
    }

    public fun rarity_for_roll(arg0: u64, arg1: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::RarityCutoffs) : u8 {
        if (arg0 < 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::uncommon_at(arg1)) {
            0
        } else if (arg0 < 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::rare_at(arg1)) {
            1
        } else if (arg0 < 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::legendary_at(arg1)) {
            2
        } else if (arg0 < 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::genesis_at(arg1)) {
            3
        } else {
            4
        }
    }

    public fun rarity_genesis() : u8 {
        4
    }

    public fun rarity_legendary() : u8 {
        3
    }

    fun rarity_multiplier_bps(arg0: u8) : u64 {
        if (arg0 == 1) {
            12000
        } else if (arg0 == 2) {
            15000
        } else if (arg0 == 3) {
            20000
        } else if (arg0 == 4) {
            22000
        } else {
            10000
        }
    }

    public fun rarity_rare() : u8 {
        2
    }

    public fun rarity_uncommon() : u8 {
        1
    }

    fun saturating_sub(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public fun serial(arg0: &Bonsai) : u64 {
        arg0.serial
    }

    public(friend) fun settle_bonexp(arg0: &mut ArenaEntry, arg1: &mut Bonsai, arg2: &mut 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BonexpVault, arg3: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::Config, arg4: u64, arg5: u64) {
        let v0 = arg5 - arg1.bonexp_synced_at_ms;
        let v1 = 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::bonexp_accrual_cap_ms(arg3);
        let v2 = if (v0 > v1) {
            v1
        } else {
            v0
        };
        let v3 = mul_bps(mul_bps(mul_div(mul_div(v2, 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::bonexp_per_hour(arg3), 3600000), arg1.power, arg1.max_power), rarity_multiplier_bps(arg1.rarity)), 10000 + age_bonus_bps(arg3, arg1.age + arg4 - arg0.stationed_at_epoch));
        if (v3 > 0) {
            0x2::balance::join<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(&mut arg0.unbanked, 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::mint_balance(arg2, v3));
        };
        let v4 = 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::power_regen_per_hour(arg3);
        if (v4 > 0) {
            let v5 = arg1.power + mul_div(v2, v4, 3600000);
            let v6 = if (v5 > arg1.max_power) {
                arg1.max_power
            } else {
                v5
            };
            arg1.power = v6;
        };
        arg1.bonexp_synced_at_ms = arg5;
    }

    public fun setup_bonsai_royalty(arg0: &0x2::package::Publisher, arg1: u16, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<Bonsai>(arg0, arg3);
        let v2 = v1;
        let v3 = v0;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Bonsai>(&mut v3, &v2, arg1, arg2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Bonsai>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Bonsai>>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun stationed(arg0: &Arena) : u64 {
        arg0.stationed
    }

    public fun stationed_at_epoch(arg0: &Arena, arg1: 0x2::object::ID) : u64 {
        0x2::table::borrow<0x2::object::ID, ArenaEntry>(&arg0.entries, arg1).stationed_at_epoch
    }

    public fun unbanked_value(arg0: &Arena, arg1: 0x2::object::ID) : u64 {
        0x2::balance::value<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(&0x2::table::borrow<0x2::object::ID, ArenaEntry>(&arg0.entries, arg1).unbanked)
    }

    public fun variation(arg0: &Bonsai) : u64 {
        arg0.variation
    }

    public fun water_with_bonexp(arg0: &mut Arena, arg1: &mut 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BonexpVault, arg2: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::Config, arg3: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::assert_version(arg2);
        assert!(!0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::paused(arg2), 10);
        apply_water(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        let v0 = 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::water_price_bonexp(arg2);
        assert!(0x2::coin::value<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(&arg5) >= v0, 0);
        if (0x2::coin::value<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(&arg5) == 0) {
            0x2::coin::destroy_zero<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(arg5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>>(arg5, 0x2::tx_context::sender(arg7));
        };
        0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::burn(arg1, 0x2::coin::split<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BONEXP>(&mut arg5, v0, arg7));
        let v1 = WaterEvent{
            bonsai_id        : arg4,
            owner            : 0x2::tx_context::sender(arg7),
            paid_with_bonexp : true,
        };
        0x2::event::emit<WaterEvent>(v1);
    }

    public fun water_with_sui(arg0: &mut Arena, arg1: &mut 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::bonexp::BonexpVault, arg2: &mut 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::GameBank, arg3: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::Config, arg4: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard, arg5: 0x2::object::ID, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::assert_version(arg3);
        assert!(!0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::paused(arg3), 10);
        apply_water(arg0, arg1, arg3, arg4, arg5, arg7, arg8);
        collect(arg2, arg6, 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::water_price_sui(arg3), 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::action_dev_bps(arg3), arg8);
        let v0 = WaterEvent{
            bonsai_id        : arg5,
            owner            : 0x2::tx_context::sender(arg8),
            paid_with_bonexp : false,
        };
        0x2::event::emit<WaterEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

