module 0xebad3daff012b6d2d1dec70ab0da494e2f355944e343502488c9bb202b06a919::oft_ptb_builder {
    struct OFTPtbBuilder {
        dummy_field: bool,
    }

    fun add_lz_receive_call<T0>(arg0: &mut 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::MoveCallsBuilder, arg1: &0xebad3daff012b6d2d1dec70ab0da494e2f355944e343502488c9bb202b06a919::oft::OFT<T0>, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0xebad3daff012b6d2d1dec70ab0da494e2f355944e343502488c9bb202b06a919::oft::OFT<T0>>(arg1)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0xebad3daff012b6d2d1dec70ab0da494e2f355944e343502488c9bb202b06a919::oft::oapp_object<T0>(arg1)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::ptb_builder_helper::lz_receive_call_id()));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x2::clock::Clock>(arg2)));
        let v2 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v2, 0x1::type_name::get<T0>());
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(arg0, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(oft_package(), 0x1::ascii::string(b"oft"), 0x1::ascii::string(b"lz_receive"), v0, v2, false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
    }

    fun add_lz_receive_compose_call<T0>(arg0: &mut 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::MoveCallsBuilder, arg1: &0xebad3daff012b6d2d1dec70ab0da494e2f355944e343502488c9bb202b06a919::oft::OFT<T0>, arg2: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: address, arg4: address, arg5: &0x2::clock::Clock) {
        let v0 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0xebad3daff012b6d2d1dec70ab0da494e2f355944e343502488c9bb202b06a919::oft::OFT<T0>>(arg1)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0xebad3daff012b6d2d1dec70ab0da494e2f355944e343502488c9bb202b06a919::oft::oapp_object<T0>(arg1)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::get_compose_queue(arg2, arg4)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(arg3));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::ptb_builder_helper::lz_receive_call_id()));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x2::clock::Clock>(arg5)));
        let v2 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v2, 0x1::type_name::get<T0>());
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(arg0, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(oft_package(), 0x1::ascii::string(b"oft"), 0x1::ascii::string(b"lz_receive_with_compose"), v0, v2, false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
    }

    public fun build_lz_receive_ptb<T0>(arg0: &0xebad3daff012b6d2d1dec70ab0da494e2f355944e343502488c9bb202b06a919::oft::OFT<T0>, arg1: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg2: &0xdcedfbd5aa43274ada0a8416766cc18718b5ee8be151ad5ed43ff941343395d9::oft_composer_manager::OFTComposerManager, arg3: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>, arg4: &0x2::clock::Clock) : vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        let v0 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::new();
        let v1 = 0xebad3daff012b6d2d1dec70ab0da494e2f355944e343502488c9bb202b06a919::oft_msg_codec::decode(*0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::message(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::param<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>(arg3)));
        if (0xebad3daff012b6d2d1dec70ab0da494e2f355944e343502488c9bb202b06a919::oft_msg_codec::is_composed(&v1)) {
            let v2 = &mut v0;
            add_lz_receive_compose_call<T0>(v2, arg0, arg1, 0x2::object::id_address<0xdcedfbd5aa43274ada0a8416766cc18718b5ee8be151ad5ed43ff941343395d9::oft_composer_manager::OFTComposerManager>(arg2), 0xebad3daff012b6d2d1dec70ab0da494e2f355944e343502488c9bb202b06a919::oft_msg_codec::send_to(&v1), arg4);
        } else {
            let v3 = &mut v0;
            add_lz_receive_call<T0>(v3, arg0, arg4);
        };
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::build(v0)
    }

    public fun lz_receive_info<T0>(arg0: &0xebad3daff012b6d2d1dec70ab0da494e2f355944e343502488c9bb202b06a919::oft::OFT<T0>, arg1: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg2: &0xdcedfbd5aa43274ada0a8416766cc18718b5ee8be151ad5ed43ff941343395d9::oft_composer_manager::OFTComposerManager, arg3: &0x2::clock::Clock) : vector<u8> {
        let v0 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0xebad3daff012b6d2d1dec70ab0da494e2f355944e343502488c9bb202b06a919::oft::OFT<T0>>(arg0)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>(arg1)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0xdcedfbd5aa43274ada0a8416766cc18718b5ee8be151ad5ed43ff941343395d9::oft_composer_manager::OFTComposerManager>(arg2)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::ptb_builder_helper::lz_receive_call_id()));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x2::clock::Clock>(arg3)));
        let v2 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v2, 0x1::type_name::get<T0>());
        let v3 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>();
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>(&mut v3, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(oft_package(), 0x1::ascii::string(b"oft_ptb_builder"), 0x1::ascii::string(b"build_lz_receive_ptb"), v0, v2, true, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        let v4 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u16(&mut v4, 1), 0x2::bcs::to_bytes<vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>>(&v3));
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v4)
    }

    fun oft_package() : address {
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<OFTPtbBuilder>()
    }

    // decompiled from Move bytecode v6
}

