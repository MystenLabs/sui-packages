module 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::operational_version {
    struct OperationalVersion<phantom T0: drop> has store {
        generation: u64,
    }

    public fun advance<T0: drop>(arg0: &mut OperationalVersion<T0>, arg1: &0x2::object::UID, arg2: u64) {
        let v0 = checked_next<T0>(arg0, arg2);
        arg0.generation = v0;
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_admin_events::operational_version_advanced<T0>(0x2::object::uid_to_inner(arg1), 0x1::type_name::original_id<T0>(), arg0.generation, v0);
    }

    public fun assert_current<T0: drop>(arg0: &OperationalVersion<T0>, arg1: u64) {
        assert!(arg0.generation == arg1, 12);
    }

    public fun assert_next<T0: drop>(arg0: &OperationalVersion<T0>, arg1: u64) {
        checked_next<T0>(arg0, arg1);
    }

    fun checked_next<T0: drop>(arg0: &OperationalVersion<T0>, arg1: u64) : u64 {
        let v0 = 0x1::u64::checked_add(arg0.generation, 1);
        if (0x1::option::is_some<u64>(&v0)) {
            let v1 = 0x1::option::destroy_some<u64>(v0);
            assert!(v1 == arg1, 12);
            return v1
        } else {
            0x1::option::destroy_none<u64>(v0);
            abort 13
        };
    }

    public fun new<T0: drop>(arg0: &T0) : OperationalVersion<T0> {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 19);
        OperationalVersion<T0>{generation: 1}
    }

    // decompiled from Move bytecode v7
}

