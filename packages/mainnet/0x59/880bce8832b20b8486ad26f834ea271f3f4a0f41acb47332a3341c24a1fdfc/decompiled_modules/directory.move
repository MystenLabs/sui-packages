module 0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::directory {
    struct PublicDirectoryCap has drop {
        dummy_field: bool,
    }

    struct AgentDirectory<phantom T0> has key {
        id: 0x2::object::UID,
        listings: 0x2::table::Table<0x2::object::ID, DirectoryEntry>,
        entry_count: u64,
    }

    struct DirectoryEntry has drop, store {
        agent_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        tags: vector<0x1::string::String>,
        listed_at: u64,
    }

    struct AgentListed has copy, drop {
        directory_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        owner: address,
    }

    struct AgentDelisted has copy, drop {
        directory_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
    }

    public fun contains<T0>(arg0: &AgentDirectory<T0>, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, DirectoryEntry>(&arg0.listings, arg1)
    }

    public fun create_directory<T0>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AgentDirectory<T0>{
            id          : 0x2::object::new(arg1),
            listings    : 0x2::table::new<0x2::object::ID, DirectoryEntry>(arg1),
            entry_count : 0,
        };
        0x2::transfer::share_object<AgentDirectory<T0>>(v0);
    }

    public fun delist<T0>(arg0: &mut AgentDirectory<T0>, arg1: &T0, arg2: &0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::identity::AgentIdentity) {
        let v0 = 0x2::object::id<0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::identity::AgentIdentity>(arg2);
        assert!(0x2::table::contains<0x2::object::ID, DirectoryEntry>(&arg0.listings, v0), 1);
        0x2::table::remove<0x2::object::ID, DirectoryEntry>(&mut arg0.listings, v0);
        arg0.entry_count = arg0.entry_count - 1;
        let v1 = AgentDelisted{
            directory_id : 0x2::object::id<AgentDirectory<T0>>(arg0),
            agent_id     : v0,
        };
        0x2::event::emit<AgentDelisted>(v1);
    }

    public fun entry_agent_id(arg0: &DirectoryEntry) : 0x2::object::ID {
        arg0.agent_id
    }

    public fun entry_count<T0>(arg0: &AgentDirectory<T0>) : u64 {
        arg0.entry_count
    }

    public fun entry_description(arg0: &DirectoryEntry) : &0x1::string::String {
        &arg0.description
    }

    public fun entry_listed_at(arg0: &DirectoryEntry) : u64 {
        arg0.listed_at
    }

    public fun entry_name(arg0: &DirectoryEntry) : &0x1::string::String {
        &arg0.name
    }

    public fun entry_owner(arg0: &DirectoryEntry) : address {
        arg0.owner
    }

    public fun entry_tags(arg0: &DirectoryEntry) : &vector<0x1::string::String> {
        &arg0.tags
    }

    public fun list<T0>(arg0: &mut AgentDirectory<T0>, arg1: &T0, arg2: &0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::identity::AgentIdentity, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::identity::AgentIdentity>(arg2);
        assert!(!0x2::table::contains<0x2::object::ID, DirectoryEntry>(&arg0.listings, v0), 0);
        let v1 = DirectoryEntry{
            agent_id    : v0,
            owner       : 0x2::tx_context::sender(arg3),
            name        : *0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::identity::name(arg2),
            description : *0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::identity::description(arg2),
            tags        : *0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::identity::tags(arg2),
            listed_at   : 0x2::tx_context::epoch(arg3),
        };
        0x2::table::add<0x2::object::ID, DirectoryEntry>(&mut arg0.listings, v0, v1);
        arg0.entry_count = arg0.entry_count + 1;
        let v2 = AgentListed{
            directory_id : 0x2::object::id<AgentDirectory<T0>>(arg0),
            agent_id     : v0,
            owner        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AgentListed>(v2);
    }

    public fun lookup<T0>(arg0: &AgentDirectory<T0>, arg1: 0x2::object::ID) : &DirectoryEntry {
        0x2::table::borrow<0x2::object::ID, DirectoryEntry>(&arg0.listings, arg1)
    }

    public fun new_public_cap() : PublicDirectoryCap {
        PublicDirectoryCap{dummy_field: false}
    }

    public fun update_listing<T0>(arg0: &mut AgentDirectory<T0>, arg1: &T0, arg2: &0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::identity::AgentIdentity, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::identity::AgentIdentity>(arg2);
        assert!(0x2::table::contains<0x2::object::ID, DirectoryEntry>(&arg0.listings, v0), 1);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, DirectoryEntry>(&mut arg0.listings, v0);
        v1.owner = 0x2::tx_context::sender(arg3);
        v1.name = *0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::identity::name(arg2);
        v1.description = *0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::identity::description(arg2);
        v1.tags = *0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::identity::tags(arg2);
    }

    // decompiled from Move bytecode v6
}

