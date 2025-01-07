module 0x3161f40cc883773de0e43061ec01d29da93dcb775935f77c2a1850951a912773::deploy_hook {
    public entry fun run(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3161f40cc883773de0e43061ec01d29da93dcb775935f77c2a1850951a912773::dapp_system::create(0x1::ascii::string(b"counter"), 0x1::ascii::string(b"counter contract"), arg0, arg1);
        let v1 = 0x3161f40cc883773de0e43061ec01d29da93dcb775935f77c2a1850951a912773::counter_schema::create(arg1);
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::set<u32>(0x3161f40cc883773de0e43061ec01d29da93dcb775935f77c2a1850951a912773::counter_schema::borrow_mut_value(&mut v1), 0);
        0x3161f40cc883773de0e43061ec01d29da93dcb775935f77c2a1850951a912773::dapp_schema::add_schema<0x3161f40cc883773de0e43061ec01d29da93dcb775935f77c2a1850951a912773::counter_schema::Counter>(&mut v0, v1, arg1);
        0x2::transfer::public_share_object<0x3161f40cc883773de0e43061ec01d29da93dcb775935f77c2a1850951a912773::dapp_schema::Dapp>(v0);
    }

    // decompiled from Move bytecode v6
}

