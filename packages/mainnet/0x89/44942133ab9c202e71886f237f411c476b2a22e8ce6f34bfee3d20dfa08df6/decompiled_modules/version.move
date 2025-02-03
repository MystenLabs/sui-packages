module 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun assert_current_version(arg0: &Version) {
        assert!(is_current_version(arg0), 9223372204358500353);
    }

    public(friend) fun create_version(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id    : 0x2::object::new(arg0),
            value : 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::current_version::current_version(),
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public fun is_current_version(arg0: &Version) : bool {
        arg0.value == 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::current_version::current_version()
    }

    public fun upgrade(arg0: &mut Version, arg1: &0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::admin::AdminCap) {
        assert!(arg0.value == 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::current_version::current_version() - 1, 9223372165703794689);
        arg0.value = 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::current_version::current_version();
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

