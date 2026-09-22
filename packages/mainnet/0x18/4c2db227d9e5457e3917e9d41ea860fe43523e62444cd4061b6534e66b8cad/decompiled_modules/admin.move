module 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::admin {
    public fun deauthorize_assistant(arg0: &mut 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::AchievementRegistry, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: 0x2::object::ID) {
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::authority::assert_admin_cap(0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::borrow_uid(arg0), arg1);
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::authority::deauthorize_assistant(0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::borrow_uid_mut(arg0), arg2);
    }

    public fun mint_assistant_cap(arg0: &mut 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::AchievementRegistry, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::authority::assert_admin_cap(0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::borrow_uid(arg0), arg1);
        0x2::transfer::public_transfer<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>>(0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::authority::create_multiton_assistant_cap(0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::borrow_uid_mut(arg0), arg3), arg2);
    }

    public fun register_definition(arg0: &mut 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::AchievementRegistry, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: bool) {
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::authority::assert_admin_cap(0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::borrow_uid(arg0), arg1);
        let v0 = 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::definition::new(arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::add_definition(arg0, v0);
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::events::emit_register_definition(*0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::definition::id(&v0));
    }

    public fun set_definition_enabled(arg0: &mut 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::AchievementRegistry, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: 0x1::string::String, arg3: bool) {
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::authority::assert_admin_cap(0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::borrow_uid(arg0), arg1);
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::definition::set_enabled(0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::borrow_definition_mut(arg0, arg2), arg3);
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::events::emit_set_definition_enabled(arg2, arg3);
    }

    public fun update_definition(arg0: &mut 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::AchievementRegistry, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64) {
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::authority::assert_admin_cap(0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::borrow_uid(arg0), arg1);
        0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::definition::update(0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry::borrow_definition_mut(arg0, arg2), arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v7
}

