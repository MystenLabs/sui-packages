module 0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin {
    struct Version has key {
        id: 0x2::object::UID,
        value: u64,
        u64_padding: vector<u64>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id          : 0x2::object::new(arg0),
            value       : 1,
            u64_padding : vector[],
        };
        0x2::transfer::share_object<Version>(v0);
    }

    entry fun upgrade(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut Version, arg2: &0x2::tx_context::TxContext) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::assert_authority(arg0, arg2);
        version_check(arg1);
        arg1.value = 1;
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    public fun value_of_this_package() : u64 {
        1
    }

    public(friend) fun version_check(arg0: &Version) {
        assert!(1 >= arg0.value, 2900);
    }

    // decompiled from Move bytecode v7
}

