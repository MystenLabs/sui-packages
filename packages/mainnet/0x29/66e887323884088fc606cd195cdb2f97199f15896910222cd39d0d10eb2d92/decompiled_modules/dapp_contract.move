module 0x2966e887323884088fc606cd195cdb2f97199f15896910222cd39d0d10eb2d92::dapp_contract {
    public entry fun i_receive(arg0: &mut 0x2966e887323884088fc606cd195cdb2f97199f15896910222cd39d0d10eb2d92::asset_forwarder::AssetForwarder, arg1: &mut 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::gateway_contract::GatewayContract, arg2: 0x2::transfer::Receiving<0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::gateway_contract::ExecuteDappIReceive>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::transfer::public_receive<0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::gateway_contract::ExecuteDappIReceive>(0x2966e887323884088fc606cd195cdb2f97199f15896910222cd39d0d10eb2d92::asset_forwarder::borrow_mut_id(arg0), arg2);
        let (_, v2, _) = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::gateway_contract::get_i_receive_args(&v0);
        let v4 = 0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::reader::new_reader(v2);
        let v5 = 0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::reader::read_vector_bytes(&v4, 1);
        let v6 = 0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::reader::read_vector_u256(&v4, 2);
        let v7 = 0;
        while (v7 < 0x1::vector::length<vector<u8>>(&v5)) {
            let v8 = 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v5, v7));
            0x2966e887323884088fc606cd195cdb2f97199f15896910222cd39d0d10eb2d92::asset_forwarder::add_withdrawable_balance(arg0, 0x2966e887323884088fc606cd195cdb2f97199f15896910222cd39d0d10eb2d92::helper::get_user_balances_key(0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::reader::read_address(&v4, 0), &v8), (*0x1::vector::borrow<u256>(&v6, v7) as u64));
            v7 = v7 + 1;
        };
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::gateway_contract::executed_i_receive_dapp(arg1, v0, b"", true, arg3);
    }

    // decompiled from Move bytecode v6
}

