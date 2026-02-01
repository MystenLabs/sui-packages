module 0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::skill {
    struct SkillPublished has copy, drop {
        skill_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        name: 0x1::string::String,
        version: 0x1::string::String,
        verification_type: u8,
        base_price_mist: u64,
        worker_bond_mist: u64,
        published_at: u64,
    }

    struct SkillDeprecated has copy, drop {
        skill_id: 0x2::object::ID,
        deprecated_at: u64,
    }

    struct Skill has key {
        id: 0x2::object::UID,
        agent_id: 0x2::object::ID,
        name: 0x1::string::String,
        version: 0x1::string::String,
        input_schema_hash: 0x1::string::String,
        output_schema_hash: 0x1::string::String,
        verification_type: u8,
        base_price_mist: u64,
        worker_bond_mist: u64,
        timeout_seconds: u64,
        priority_multipliers: vector<u64>,
        metadata_uri: 0x1::string::String,
        published_at: u64,
        deprecated: bool,
    }

    public fun id(arg0: &Skill) : 0x2::object::ID {
        0x2::object::id<Skill>(arg0)
    }

    public fun agent_id(arg0: &Skill) : 0x2::object::ID {
        arg0.agent_id
    }

    public fun base_price_mist(arg0: &Skill) : u64 {
        arg0.base_price_mist
    }

    public fun calculate_price(arg0: &Skill, arg1: u8) : u64 {
        arg0.base_price_mist * priority_multiplier(arg0, arg1) / 10000
    }

    public fun deprecate(arg0: &mut Skill, arg1: &0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::owner(arg1) == 0x2::tx_context::sender(arg2), 0);
        assert!(0x2::object::id<0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent>(arg1) == arg0.agent_id, 1);
        assert!(!arg0.deprecated, 18);
        arg0.deprecated = true;
        let v0 = SkillDeprecated{
            skill_id      : 0x2::object::id<Skill>(arg0),
            deprecated_at : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<SkillDeprecated>(v0);
    }

    public fun deprecated(arg0: &Skill) : bool {
        arg0.deprecated
    }

    public fun input_schema_hash(arg0: &Skill) : 0x1::string::String {
        arg0.input_schema_hash
    }

    public fun is_active(arg0: &Skill) : bool {
        !arg0.deprecated
    }

    public fun metadata_uri(arg0: &Skill) : 0x1::string::String {
        arg0.metadata_uri
    }

    public fun name(arg0: &Skill) : 0x1::string::String {
        arg0.name
    }

    public fun output_schema_hash(arg0: &Skill) : 0x1::string::String {
        arg0.output_schema_hash
    }

    public fun priority_multiplier(arg0: &Skill, arg1: u8) : u64 {
        *0x1::vector::borrow<u64>(&arg0.priority_multipliers, (arg1 as u64))
    }

    public fun publish(arg0: &0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u64>, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::owner(arg0) == 0x2::tx_context::sender(arg11), 0);
        assert!(arg5 <= 2, 21);
        assert!(arg8 >= 300 && arg8 <= 604800, 22);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg11);
        let v1 = 0x2::object::id<0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent>(arg0);
        let v2 = if (0x1::vector::is_empty<u64>(&arg9)) {
            vector[10000, 15000, 25000]
        } else {
            assert!(0x1::vector::length<u64>(&arg9) == 3, 20);
            arg9
        };
        let v3 = Skill{
            id                   : 0x2::object::new(arg11),
            agent_id             : v1,
            name                 : arg1,
            version              : arg2,
            input_schema_hash    : arg3,
            output_schema_hash   : arg4,
            verification_type    : arg5,
            base_price_mist      : arg6,
            worker_bond_mist     : arg7,
            timeout_seconds      : arg8,
            priority_multipliers : v2,
            metadata_uri         : arg10,
            published_at         : v0,
            deprecated           : false,
        };
        let v4 = SkillPublished{
            skill_id          : 0x2::object::id<Skill>(&v3),
            agent_id          : v1,
            name              : v3.name,
            version           : v3.version,
            verification_type : arg5,
            base_price_mist   : arg6,
            worker_bond_mist  : arg7,
            published_at      : v0,
        };
        0x2::event::emit<SkillPublished>(v4);
        0x2::transfer::share_object<Skill>(v3);
    }

    public fun published_at(arg0: &Skill) : u64 {
        arg0.published_at
    }

    public fun reactivate(arg0: &mut Skill, arg1: &0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::owner(arg1) == 0x2::tx_context::sender(arg2), 0);
        assert!(0x2::object::id<0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent>(arg1) == arg0.agent_id, 1);
        assert!(arg0.deprecated, 2);
        arg0.deprecated = false;
    }

    public fun timeout_seconds(arg0: &Skill) : u64 {
        arg0.timeout_seconds
    }

    public fun update_metadata(arg0: &mut Skill, arg1: &0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::owner(arg1) == 0x2::tx_context::sender(arg3), 0);
        assert!(0x2::object::id<0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent>(arg1) == arg0.agent_id, 1);
        arg0.metadata_uri = arg2;
    }

    public fun update_pricing(arg0: &mut Skill, arg1: &0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::owner(arg1) == 0x2::tx_context::sender(arg4), 0);
        assert!(0x2::object::id<0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent>(arg1) == arg0.agent_id, 1);
        arg0.base_price_mist = arg2;
        arg0.worker_bond_mist = arg3;
    }

    public fun update_timeout(arg0: &mut Skill, arg1: &0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::owner(arg1) == 0x2::tx_context::sender(arg3), 0);
        assert!(0x2::object::id<0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent>(arg1) == arg0.agent_id, 1);
        assert!(arg2 >= 300 && arg2 <= 604800, 22);
        arg0.timeout_seconds = arg2;
    }

    public fun verification_type(arg0: &Skill) : u8 {
        arg0.verification_type
    }

    public fun version(arg0: &Skill) : 0x1::string::String {
        arg0.version
    }

    public fun worker_bond_mist(arg0: &Skill) : u64 {
        arg0.worker_bond_mist
    }

    // decompiled from Move bytecode v6
}

