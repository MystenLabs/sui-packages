module 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::migration {
    struct MigrationStarted has copy, drop {
        compatible_versions: vector<u64>,
    }

    struct MigrationAborted has copy, drop {
        compatible_versions: vector<u64>,
    }

    struct MigrationCompleted has copy, drop {
        compatible_versions: vector<u64>,
    }

    entry fun abort_migration(arg0: &mut 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::State, arg1: &0x2::tx_context::TxContext) {
        assert!(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::roles::owner(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::roles(arg0)) == 0x2::tx_context::sender(arg1), 0);
        assert!(0x2::vec_set::size<u64>(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::compatible_versions(arg0)) == 2, 101);
        let v0 = 0x1::u64::max(*0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::compatible_versions(arg0)), 0), *0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::compatible_versions(arg0)), 1));
        assert!(v0 == 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::version_control::current_version(), 103);
        0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::remove_compatible_version(arg0, v0);
        let v1 = MigrationAborted{compatible_versions: *0x2::vec_set::keys<u64>(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::compatible_versions(arg0))};
        0x2::event::emit<MigrationAborted>(v1);
    }

    entry fun complete_migration(arg0: &mut 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::State, arg1: &0x2::tx_context::TxContext) {
        assert!(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::roles::owner(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::roles(arg0)) == 0x2::tx_context::sender(arg1), 0);
        assert!(0x2::vec_set::size<u64>(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::compatible_versions(arg0)) == 2, 101);
        let v0 = *0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::compatible_versions(arg0)), 0);
        let v1 = *0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::compatible_versions(arg0)), 1);
        assert!(0x1::u64::max(v0, v1) == 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::version_control::current_version(), 103);
        0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::remove_compatible_version(arg0, 0x1::u64::min(v0, v1));
        let v2 = MigrationCompleted{compatible_versions: *0x2::vec_set::keys<u64>(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::compatible_versions(arg0))};
        0x2::event::emit<MigrationCompleted>(v2);
    }

    entry fun start_migration(arg0: &mut 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::State, arg1: &0x2::tx_context::TxContext) {
        assert!(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::roles::owner(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::roles(arg0)) == 0x2::tx_context::sender(arg1), 0);
        assert!(0x2::vec_set::size<u64>(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::compatible_versions(arg0)) == 1, 100);
        assert!(*0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::compatible_versions(arg0)), 0) < 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::version_control::current_version(), 102);
        0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::add_compatible_version(arg0, 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::version_control::current_version());
        let v0 = MigrationStarted{compatible_versions: *0x2::vec_set::keys<u64>(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::compatible_versions(arg0))};
        0x2::event::emit<MigrationStarted>(v0);
    }

    // decompiled from Move bytecode v6
}

