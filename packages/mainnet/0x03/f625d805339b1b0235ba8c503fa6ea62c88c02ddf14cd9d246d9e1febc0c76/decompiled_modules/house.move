module 0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house {
    struct DiscountHouse has store, key {
        id: 0x2::object::UID,
        version: u8,
    }

    public(friend) fun assert_version_is_valid(arg0: &DiscountHouse) {
        assert!(arg0.version == 1, 9223372217243402241);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DiscountHouse{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::public_share_object<DiscountHouse>(v0);
    }

    public fun set_version(arg0: &mut DiscountHouse, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg2: u8) {
        arg0.version = arg2;
    }

    public(friend) fun uid_mut(arg0: &mut DiscountHouse) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

