module 0x782b10407dd5eb94c696ad3e0db6302872e63d593f60849a2856b5f94fac1db8::deploy_hook {
    public entry fun run(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x782b10407dd5eb94c696ad3e0db6302872e63d593f60849a2856b5f94fac1db8::dapp_system::create(0x1::ascii::string(b"counter"), 0x1::ascii::string(b"counter contract"), arg0, arg1);
        let v1 = 0x782b10407dd5eb94c696ad3e0db6302872e63d593f60849a2856b5f94fac1db8::counter_schema::create(arg1);
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::set<u32>(0x782b10407dd5eb94c696ad3e0db6302872e63d593f60849a2856b5f94fac1db8::counter_schema::borrow_mut_value(&mut v1), 0);
        0x782b10407dd5eb94c696ad3e0db6302872e63d593f60849a2856b5f94fac1db8::dapp_schema::add_schema<0x782b10407dd5eb94c696ad3e0db6302872e63d593f60849a2856b5f94fac1db8::counter_schema::Counter>(&mut v0, v1, arg1);
        0x2::transfer::public_share_object<0x782b10407dd5eb94c696ad3e0db6302872e63d593f60849a2856b5f94fac1db8::dapp_schema::Dapp>(v0);
    }

    // decompiled from Move bytecode v6
}

