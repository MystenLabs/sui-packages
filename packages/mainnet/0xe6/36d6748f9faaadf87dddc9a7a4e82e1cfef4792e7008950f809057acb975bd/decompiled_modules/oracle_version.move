module 0xe636d6748f9faaadf87dddc9a7a4e82e1cfef4792e7008950f809057acb975bd::oracle_version {
    public fun next_version() : u64 {
        0xe636d6748f9faaadf87dddc9a7a4e82e1cfef4792e7008950f809057acb975bd::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xe636d6748f9faaadf87dddc9a7a4e82e1cfef4792e7008950f809057acb975bd::oracle_constants::version(), 0xe636d6748f9faaadf87dddc9a7a4e82e1cfef4792e7008950f809057acb975bd::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xe636d6748f9faaadf87dddc9a7a4e82e1cfef4792e7008950f809057acb975bd::oracle_constants::version()
    }

    // decompiled from Move bytecode v7
}

