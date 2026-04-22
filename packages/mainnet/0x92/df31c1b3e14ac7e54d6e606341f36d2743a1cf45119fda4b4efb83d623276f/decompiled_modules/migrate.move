module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::migrate {
    entry fun create_price_feed_from_registry(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::version() == 4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_protocol_version());
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::price_feed::new_for_migration(arg2);
        if (0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::perpetual_registry_exists(arg0)) {
            let v1 = 0x2::vec_set::keys<0x2::object::ID>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::borrow_perpetual_ids(arg0));
            let v2 = 0;
            while (v2 < 0x1::vector::length<0x2::object::ID>(v1)) {
                0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::price_feed::insert_price_info(&mut v0, *0x1::vector::borrow<0x2::object::ID>(v1, v2), 0, 0);
                v2 = v2 + 1;
            };
        };
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::price_feed::share_price_feed(v0);
    }

    entry fun create_vault_config(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeAdminCap, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: address, arg3: u128, arg4: u128, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg1);
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::version() == 2, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_protocol_version());
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::vault::create_vault_config(arg2, arg3, arg4, arg5, arg6);
    }

    entry fun register_perpetual(arg0: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::version() == 2, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::invalid_protocol_version());
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::register_perpetual(arg0, 0x2::object::uid_to_inner(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::id(arg2)));
    }

    // decompiled from Move bytecode v6
}

