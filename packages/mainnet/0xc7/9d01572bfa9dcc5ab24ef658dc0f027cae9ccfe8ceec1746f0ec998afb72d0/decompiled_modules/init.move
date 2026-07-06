module 0xc79d01572bfa9dcc5ab24ef658dc0f027cae9ccfe8ceec1746f0ec998afb72d0::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc79d01572bfa9dcc5ab24ef658dc0f027cae9ccfe8ceec1746f0ec998afb72d0::config::new<INIT>(&arg0, arg1);
        0xc79d01572bfa9dcc5ab24ef658dc0f027cae9ccfe8ceec1746f0ec998afb72d0::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0xc79d01572bfa9dcc5ab24ef658dc0f027cae9ccfe8ceec1746f0ec998afb72d0::config::borrow_mut_id(&mut v0), arg1);
        0xc79d01572bfa9dcc5ab24ef658dc0f027cae9ccfe8ceec1746f0ec998afb72d0::vault::create_vault_and_share<INIT>(&arg0, 0xc79d01572bfa9dcc5ab24ef658dc0f027cae9ccfe8ceec1746f0ec998afb72d0::config::borrow_mut_id(&mut v0), arg1);
        0x2::transfer::public_share_object<0xc79d01572bfa9dcc5ab24ef658dc0f027cae9ccfe8ceec1746f0ec998afb72d0::config::Config>(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

