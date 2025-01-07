module 0x561043b1c6135403a4c5f392fa31ee44c51ec03368a65ad2e378d43c595f7697::poap_manager {
    struct PoapManager has store {
        config: PoapConfig,
        visitors: 0x2::vec_set::VecSet<address>,
        poap_table: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct PoapConfig has copy, drop, store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x1::string::String,
    }

    struct LogMintPoap has copy, drop {
        holder: address,
        poap_id: 0x2::object::ID,
    }

    public fun check_can_mint(arg0: &PoapManager, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        0x12bcd1e69ec3091c4aad89d3cb0cb6d5b96cbe4a0c98ea6fb10ab967672666d8::alert::alert(!0x2::vec_set::contains<address>(&arg0.visitors, &arg1), 103);
        0x12bcd1e69ec3091c4aad89d3cb0cb6d5b96cbe4a0c98ea6fb10ab967672666d8::alert::alert(0x2::clock::timestamp_ms(arg4) >= arg2, 104);
        0x12bcd1e69ec3091c4aad89d3cb0cb6d5b96cbe4a0c98ea6fb10ab967672666d8::alert::alert(0x2::clock::timestamp_ms(arg4) < arg3, 105);
    }

    public(friend) fun default(arg0: &mut 0x2::tx_context::TxContext) : PoapManager {
        let v0 = PoapConfig{
            name        : 0x1::string::utf8(b""),
            description : 0x1::string::utf8(b""),
            img_url     : 0x1::string::utf8(b""),
        };
        PoapManager{
            config     : v0,
            visitors   : 0x2::vec_set::empty<address>(),
            poap_table : 0x2::table::new<address, 0x2::object::ID>(arg0),
        }
    }

    public fun get_poap_id_for_visitor(arg0: &PoapManager, arg1: address) : 0x2::object::ID {
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.poap_table, arg1)
    }

    public(friend) fun mint_poap(arg0: &mut PoapManager, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        check_can_mint(arg0, arg2, arg3, arg4, arg5);
        let v0 = 0x561043b1c6135403a4c5f392fa31ee44c51ec03368a65ad2e378d43c595f7697::poap::new(arg0.config.name, arg0.config.description, arg0.config.img_url, arg1, arg5, arg6);
        let v1 = 0x2::object::id<0x561043b1c6135403a4c5f392fa31ee44c51ec03368a65ad2e378d43c595f7697::poap::PoapObject>(&v0);
        0x2::vec_set::insert<address>(&mut arg0.visitors, arg2);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.poap_table, arg2, v1);
        0x2::transfer::public_transfer<0x561043b1c6135403a4c5f392fa31ee44c51ec03368a65ad2e378d43c595f7697::poap::PoapObject>(v0, arg2);
        let v2 = LogMintPoap{
            holder  : arg2,
            poap_id : v1,
        };
        0x2::event::emit<LogMintPoap>(v2);
        v1
    }

    public(friend) fun update(arg0: &mut PoapManager, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        arg0.config.name = arg1;
        arg0.config.description = arg2;
        arg0.config.img_url = arg3;
    }

    public fun visitors(arg0: &PoapManager) : &0x2::vec_set::VecSet<address> {
        &arg0.visitors
    }

    // decompiled from Move bytecode v6
}

