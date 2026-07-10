module 0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::config::new<INIT>(&arg0, arg1);
        0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::config::borrow_mut_id(&mut v0), arg1);
        0x2::transfer::public_share_object<0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::config::Config>(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

