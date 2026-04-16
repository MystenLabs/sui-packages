module 0x7ab08860460bbf5357d940a9b2c2655b05eef3574dc6aacf49ade3b2e328fc69::ptb_builder {
    struct MsgPtbBuilder {
        dummy_field: bool,
    }

    public fun build_lz_receive_ptb(arg0: &0x7ab08860460bbf5357d940a9b2c2655b05eef3574dc6aacf49ade3b2e328fc69::messenger_oapp::State, arg1: &0xfcc3a7785cee55c4e9e7a34efc865cd3dd3671544c914c756d56c27b9792413a::mtoken::State<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>, arg2: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp) : vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall> {
        let v0 = 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::new();
        let v1 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v2 = &mut v1;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v2, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x7ab08860460bbf5357d940a9b2c2655b05eef3574dc6aacf49ade3b2e328fc69::messenger_oapp::State>(arg0)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v2, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0xfcc3a7785cee55c4e9e7a34efc865cd3dd3671544c914c756d56c27b9792413a::mtoken::State<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>>(arg1)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v2, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg2)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v2, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_id(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::ptb_builder_helper::lz_receive_call_id()));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v2, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(@0x403));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::add(&mut v0, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(msg_package(), 0x1::ascii::string(b"messenger_oapp"), 0x1::ascii::string(b"lz_receive"), v1, 0x1::vector::empty<0x1::type_name::TypeName>(), false, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_calls_builder::build(v0)
    }

    public fun lz_receive_info(arg0: &0x7ab08860460bbf5357d940a9b2c2655b05eef3574dc6aacf49ade3b2e328fc69::messenger_oapp::State, arg1: &0xfcc3a7785cee55c4e9e7a34efc865cd3dd3671544c914c756d56c27b9792413a::mtoken::State<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>, arg2: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp) : vector<u8> {
        let v0 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0x7ab08860460bbf5357d940a9b2c2655b05eef3574dc6aacf49ade3b2e328fc69::messenger_oapp::State>(arg0)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0xfcc3a7785cee55c4e9e7a34efc865cd3dd3671544c914c756d56c27b9792413a::mtoken::State<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>>(arg1)));
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::Argument>(v1, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::argument::create_object(0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg2)));
        let v2 = 0x1::vector::empty<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>();
        0x1::vector::push_back<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>(&mut v2, 0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::create(msg_package(), 0x1::ascii::string(b"ptb_builder"), 0x1::ascii::string(b"build_lz_receive_ptb"), v0, 0x1::vector::empty<0x1::type_name::TypeName>(), true, 0x1::vector::empty<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>()));
        let v3 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u16(&mut v3, 1), 0x2::bcs::to_bytes<vector<0xc44d4a8623333b1a1d1397d23da4f12298b5763390f245dc7acba2ad98fbc2be::move_call::MoveCall>>(&v2));
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v3)
    }

    public fun msg_package() : address {
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<MsgPtbBuilder>()
    }

    // decompiled from Move bytecode v7
}

