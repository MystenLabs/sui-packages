module 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_genesis {
    public entry fun run(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_dapp_system::create(0x1::ascii::string(b"numeron"), 0x1::ascii::string(b"numeron contract"), arg0, arg1);
        let v1 = 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::create(arg1);
        0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_deploy_hook::run(&mut v1, arg1);
        0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_dapp_schema::add_schema<0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::Schema>(&mut v0, v1);
        0x2::transfer::public_share_object<0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_dapp_schema::Dapp>(v0);
    }

    // decompiled from Move bytecode v6
}

