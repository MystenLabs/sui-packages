module 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::display {
    struct DISPLAY has drop {
        dummy_field: bool,
    }

    struct PermissionedGroupPublisher has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
    }

    fun init(arg0: DISPLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PermissionedGroupPublisher{
            id        : 0x2::object::new(arg1),
            publisher : 0x2::package::claim<DISPLAY>(arg0, arg1),
        };
        0x2::transfer::share_object<PermissionedGroupPublisher>(v0);
    }

    public fun setup_display<T0: drop>(arg0: &PermissionedGroupPublisher, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<T0>(arg1), 0);
        let v0 = 0x2::display::new<0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<T0>>(&arg0.publisher, arg7);
        0x2::display::add<0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<T0>>(&mut v0, 0x1::string::utf8(b"name"), arg2);
        0x2::display::add<0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<T0>>(&mut v0, 0x1::string::utf8(b"description"), arg3);
        0x2::display::add<0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<T0>>(&mut v0, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::add<0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<T0>>(&mut v0, 0x1::string::utf8(b"image_url"), arg4);
        0x2::display::add<0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<T0>>(&mut v0, 0x1::string::utf8(b"project_url"), arg5);
        0x2::display::add<0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<T0>>(&mut v0, 0x1::string::utf8(b"link"), arg6);
        0x2::display::update_version<0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<T0>>(&mut v0);
        0x2::transfer::public_transfer<0x2::display::Display<0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<T0>>>(v0, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

