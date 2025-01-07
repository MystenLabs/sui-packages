module 0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::utils {
    struct UTILS has drop {
        dummy_field: bool,
    }

    public fun check_version(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version) {
        let v0 = 0x1::type_name::get<UTILS>();
        let v1 = 0x1::type_name::get_address(&v0);
        assert!(0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::get(arg0, 0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v1)))) == 0, 0);
    }

    fun init(arg0: UTILS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<UTILS>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun new_version(arg0: &0x2::package::Publisher, arg1: &mut 0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::add(arg0, arg1);
    }

    public fun set_version(arg0: &0x2::package::Publisher, arg1: &mut 0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::set(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

