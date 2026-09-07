module 0xcca53cfec6f8d6b4b0a6bd8abf5e431f231e1e97925af06ca61e9f92d7acba8d::hub_ptb_builder {
    struct HubPtbBuilder {
        dummy_field: bool,
    }

    public fun build_lz_receive_ptb(arg0: &0xcca53cfec6f8d6b4b0a6bd8abf5e431f231e1e97925af06ca61e9f92d7acba8d::hub_oapp::HubOApp, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>, arg3: &0x2::clock::Clock) : vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        let v0 = msg_kind(*0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::message(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>(arg2)));
        if (v0 == 1) {
            let v2 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>();
            0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>(&mut v2, direct_receive_call(0x1::ascii::string(b"lz_receive_execution_outcome"), 0x2::object::id_address<0xcca53cfec6f8d6b4b0a6bd8abf5e431f231e1e97925af06ca61e9f92d7acba8d::hub_oapp::HubOApp>(arg0), 0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg1), 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::ptb_builder_helper::lz_receive_call_id(), 0x2::object::id_address<0x2::clock::Clock>(arg3)));
            v2
        } else if (v0 == 2) {
            let v3 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>();
            let v4 = &mut v3;
            0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>(v4, direct_receive_call(0x1::ascii::string(b"receive_hub_deposit"), 0x2::object::id_address<0xcca53cfec6f8d6b4b0a6bd8abf5e431f231e1e97925af06ca61e9f92d7acba8d::hub_oapp::HubOApp>(arg0), 0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg1), 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::ptb_builder_helper::lz_receive_call_id(), 0x2::object::id_address<0x2::clock::Clock>(arg3)));
            0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>(v4, consume_proof_call(0x1::ascii::string(b"consume_deposit_proof")));
            v3
        } else {
            let v5 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>();
            let v6 = &mut v5;
            0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>(v6, direct_receive_call(0x1::ascii::string(b"receive_hub_withdraw_request"), 0x2::object::id_address<0xcca53cfec6f8d6b4b0a6bd8abf5e431f231e1e97925af06ca61e9f92d7acba8d::hub_oapp::HubOApp>(arg0), 0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg1), 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::ptb_builder_helper::lz_receive_call_id(), 0x2::object::id_address<0x2::clock::Clock>(arg3)));
            0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>(v6, consume_proof_call(0x1::ascii::string(b"consume_withdraw_proof")));
            v5
        }
    }

    fun consume_proof_call(arg0: 0x1::ascii::String) : 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall {
        let v0 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(&mut v0, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_nested_result(0, 0));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(hub_package(), 0x1::ascii::string(b"hub_oapp"), arg0, v0, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>())
    }

    fun direct_receive_call(arg0: 0x1::ascii::String, arg1: address, arg2: address, arg3: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg4: address) : 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall {
        let v0 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(arg1));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(arg2));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(arg3));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(arg4));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(hub_package(), 0x1::ascii::string(b"hub_oapp"), arg0, v0, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>())
    }

    fun hub_package() : address {
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<HubPtbBuilder>()
    }

    public fun lz_receive_info(arg0: &0xcca53cfec6f8d6b4b0a6bd8abf5e431f231e1e97925af06ca61e9f92d7acba8d::hub_oapp::HubOApp, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &0x2::clock::Clock) : vector<u8> {
        let v0 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0xcca53cfec6f8d6b4b0a6bd8abf5e431f231e1e97925af06ca61e9f92d7acba8d::hub_oapp::HubOApp>(arg0)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg1)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::ptb_builder_helper::lz_receive_call_id()));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x2::clock::Clock>(arg2)));
        let v2 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>();
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>(&mut v2, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(hub_package(), 0x1::ascii::string(b"hub_ptb_builder"), 0x1::ascii::string(b"build_lz_receive_ptb"), v0, 0x1::vector::empty<0x1::type_name::TypeName>(), true, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        let v3 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u16(&mut v3, 1), 0x2::bcs::to_bytes<vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>>(&v2));
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v3)
    }

    fun msg_kind(arg0: vector<u8>) : u8 {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        let v2 = 0x2::bcs::peel_u8(&mut v0);
        let v3 = 0x2::bcs::peel_u8(&mut v0);
        let v4 = if (v1 == b"DAY_OUTCOME") {
            if (v2 == 1) {
                v3 == 1
            } else {
                false
            }
        } else {
            false
        };
        if (v4) {
            1
        } else {
            let v6 = if (v1 == b"DAY_HUB_CMD") {
                if (v2 == 1) {
                    v3 == 1
                } else {
                    false
                }
            } else {
                false
            };
            if (v6) {
                2
            } else {
                let v7 = if (v1 == b"DAY_HUB_CMD") {
                    if (v2 == 1) {
                        v3 == 2
                    } else {
                        false
                    }
                } else {
                    false
                };
                assert!(v7, 1);
                3
            }
        }
    }

    // decompiled from Move bytecode v7
}

