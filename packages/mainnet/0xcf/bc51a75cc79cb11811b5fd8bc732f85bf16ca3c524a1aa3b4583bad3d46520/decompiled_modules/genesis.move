module 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::genesis {
    public entry fun run(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_system::create(0x1::ascii::string(b"counter"), 0x1::ascii::string(b"counter contract"), arg0, arg1);
        let v1 = 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::schema::create(arg1);
        0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::deploy_hook::run(&mut v1, arg1);
        0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::add_schema<0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::schema::Schema>(&mut v0, v1);
        0x2::transfer::public_share_object<0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::dapp_schema::Dapp>(v0);
    }

    // decompiled from Move bytecode v6
}

