module 0x561043b1c6135403a4c5f392fa31ee44c51ec03368a65ad2e378d43c595f7697::gathering {
    struct Gathering has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        start_at: u64,
        end_at: u64,
        poap_manager: 0x561043b1c6135403a4c5f392fa31ee44c51ec03368a65ad2e378d43c595f7697::poap_manager::PoapManager,
        created_at: u64,
        updated_at: u64,
    }

    struct LogAdminCapId has copy, drop {
        cap_id: 0x2::object::ID,
    }

    fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Gathering {
        Gathering{
            id           : 0x2::object::new(arg5),
            name         : arg0,
            description  : arg1,
            start_at     : arg2,
            end_at       : arg3,
            poap_manager : 0x561043b1c6135403a4c5f392fa31ee44c51ec03368a65ad2e378d43c595f7697::poap_manager::default(arg5),
            created_at   : 0x2::clock::timestamp_ms(arg4),
            updated_at   : 0x2::clock::timestamp_ms(arg4),
        }
    }

    public entry fun check_cap(arg0: &Gathering, arg1: &0xe4233631538681b8cfac312cf381aa1adc7554ca7b3e5055c33dc23ed552b13::shared_cap::SharedCap<Gathering>, arg2: &0xe4233631538681b8cfac312cf381aa1adc7554ca7b3e5055c33dc23ed552b13::regulated_pointer::RegulatedPointer<0xe4233631538681b8cfac312cf381aa1adc7554ca7b3e5055c33dc23ed552b13::shared_cap::SharedCap<Gathering>>) {
        assert!(get_admin_cap_id(arg0) == 0x2::object::id<0xe4233631538681b8cfac312cf381aa1adc7554ca7b3e5055c33dc23ed552b13::shared_cap::SharedCap<Gathering>>(arg1), 257);
        0xe4233631538681b8cfac312cf381aa1adc7554ca7b3e5055c33dc23ed552b13::shared_cap::check_cap<Gathering>(arg1, arg2);
    }

    public fun create(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::dynamic_field::add<0x1::string::String, 0x2::object::ID>(&mut v0.id, admin_cap_key(), 0xe4233631538681b8cfac312cf381aa1adc7554ca7b3e5055c33dc23ed552b13::shared_cap::create<Gathering>(&v0, arg5));
        0x2::transfer::public_share_object<Gathering>(v0);
        0x2::object::id<Gathering>(&v0)
    }

    public fun admin_cap_key() : 0x1::string::String {
        0x1::string::utf8(b"admin_cap")
    }

    fun default(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : Gathering {
        Gathering{
            id           : 0x2::object::new(arg1),
            name         : 0x1::string::utf8(b""),
            description  : 0x1::string::utf8(b""),
            start_at     : 0,
            end_at       : 0,
            poap_manager : 0x561043b1c6135403a4c5f392fa31ee44c51ec03368a65ad2e378d43c595f7697::poap_manager::default(arg1),
            created_at   : 0x2::clock::timestamp_ms(arg0),
            updated_at   : 0x2::clock::timestamp_ms(arg0),
        }
    }

    public entry fun get_admin_cap_id(arg0: &Gathering) : 0x2::object::ID {
        let v0 = *0x2::dynamic_field::borrow<0x1::string::String, 0x2::object::ID>(&arg0.id, admin_cap_key());
        let v1 = LogAdminCapId{cap_id: v0};
        0x2::event::emit<LogAdminCapId>(v1);
        v0
    }

    public entry fun mint_poap(arg0: &mut Gathering, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x561043b1c6135403a4c5f392fa31ee44c51ec03368a65ad2e378d43c595f7697::poap_manager::mint_poap(&mut arg0.poap_manager, 0x2::object::id<Gathering>(arg0), 0x2::tx_context::sender(arg2), arg0.start_at, arg0.end_at, arg1, arg2)
    }

    public fun update(arg0: &mut Gathering, arg1: &0xe4233631538681b8cfac312cf381aa1adc7554ca7b3e5055c33dc23ed552b13::shared_cap::SharedCap<Gathering>, arg2: &0xe4233631538681b8cfac312cf381aa1adc7554ca7b3e5055c33dc23ed552b13::regulated_pointer::RegulatedPointer<0xe4233631538681b8cfac312cf381aa1adc7554ca7b3e5055c33dc23ed552b13::shared_cap::SharedCap<Gathering>>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        check_cap(arg0, arg1, arg2);
        arg0.name = arg3;
        arg0.description = arg4;
        arg0.start_at = arg5;
        arg0.end_at = arg6;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg7);
    }

    public fun update_poap_config(arg0: &mut Gathering, arg1: &0xe4233631538681b8cfac312cf381aa1adc7554ca7b3e5055c33dc23ed552b13::shared_cap::SharedCap<Gathering>, arg2: &0xe4233631538681b8cfac312cf381aa1adc7554ca7b3e5055c33dc23ed552b13::regulated_pointer::RegulatedPointer<0xe4233631538681b8cfac312cf381aa1adc7554ca7b3e5055c33dc23ed552b13::shared_cap::SharedCap<Gathering>>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock) {
        check_cap(arg0, arg1, arg2);
        0x561043b1c6135403a4c5f392fa31ee44c51ec03368a65ad2e378d43c595f7697::poap_manager::update(&mut arg0.poap_manager, arg3, arg4, arg5);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg6);
    }

    // decompiled from Move bytecode v6
}

