module 0x21ad4f181d0ff8c73e119b070c6821edd86ca0456da6d038da17afb628128ec8::config {
    struct StrategyConfig has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
    }

    public fun add_version(arg0: &mut StrategyConfig, arg1: &0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::PlatformCap, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.versions, arg2);
    }

    public(friend) fun assert_version(arg0: &StrategyConfig) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.versions, &v0), 100);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StrategyConfig{
            id       : 0x2::object::new(arg0),
            versions : 0x2::vec_set::singleton<u64>(package_version()),
        };
        0x2::transfer::share_object<StrategyConfig>(v0);
    }

    public fun package_version() : u64 {
        1
    }

    public fun remove_version(arg0: &mut StrategyConfig, arg1: &0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::PlatformCap, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg0.versions, &arg2);
    }

    // decompiled from Move bytecode v6
}

