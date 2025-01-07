module 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::async_vault_interface {
    public fun toggle_deposits<T0, T1>(arg0: &0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::admin::AdminCap, arg1: &mut 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::async_vault::AsyncVault<T0, T1>, arg2: bool) {
        0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::async_vault::toggle_deposits<T0, T1>(arg1, arg2);
    }

    public fun uid<T0, T1>(arg0: &0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::admin::AdminCap, arg1: &mut 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::async_vault::AsyncVault<T0, T1>) : &mut 0x2::object::UID {
        0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::async_vault::uid<T0, T1>(arg1)
    }

    public fun end_admin_withdraw<T0, T1>(arg0: &0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::admin::AdminCap, arg1: &mut 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::async_vault::AsyncVault<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::vault_reserve::VaultReserve<T0, T1>, arg4: &mut 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::SessionAsync<T0, T1>, arg5: &0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::version::Version) : 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::SessionFlow<T0, T1> {
        0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::version::assert_current_version(arg5);
        assert!(0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::kind<T0, T1>(arg4) == 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::withdraw_kind(), 9223372663920525321);
        assert!(0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::done<T0, T1>(arg4), 9223372668215361543);
        assert!(0x2::coin::value<T0>(&arg2) == 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::value<T0, T1>(arg4), 9223372672510066691);
        0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::vault_reserve::deposit<T0, T1>(arg3, arg2);
        0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::allow_consume<T0, T1>(0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::async_vault::uid<T0, T1>(arg1), arg4);
        0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::create_session<T0, T1>(0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::move_kind(), 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::value<T0, T1>(arg4))
    }

    public fun end_public_deposit<T0, T1>(arg0: &mut 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::async_vault::AsyncVault<T0, T1>, arg1: &mut 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::SessionFlow<T0, T1>, arg2: &mut 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::SessionAsync<T0, T1>, arg3: &0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::version::Version) {
        0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::version::assert_current_version(arg3);
        assert!(!0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::done<T0, T1>(arg2), 9223372285963141125);
        assert!(0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::value<T0, T1>(arg1) == 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::value<T0, T1>(arg2), 9223372290257977347);
        0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::assert_deposit<T0, T1>(arg1);
        0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::register_as_done<T0, T1>(arg1);
        0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::allow_consume<T0, T1>(0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::async_vault::uid<T0, T1>(arg0), arg2);
    }

    public fun end_public_withdraw<T0, T1>(arg0: &mut 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::async_vault::AsyncVault<T0, T1>, arg1: &mut 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::vault_reserve::VaultReserve<T0, T1>, arg2: &mut 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::SessionFlow<T0, T1>, arg3: &mut 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::SessionAsync<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: &0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::version::assert_current_version(arg5);
        assert!(0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::value<T0, T1>(arg2) == 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::value<T0, T1>(arg3), 9223372431991898115);
        assert!(0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::done<T0, T1>(arg3), 9223372436287127559);
        let v0 = 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::value<T0, T1>(arg2);
        assert!(0x2::coin::value<T0>(&arg4) == v0, 9223372444876800003);
        0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::vault_reserve::deposit<T0, T1>(arg1, arg4);
        0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::register_as_done<T0, T1>(arg2);
        0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::allow_consume<T0, T1>(0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::async_vault::uid<T0, T1>(arg0), arg3);
        0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::events::withdraw(0x2::object::id_address<0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::async_vault::AsyncVault<T0, T1>>(arg0), v0, 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::from_lending_pool<T0, T1>(arg2), 0x2::tx_context::sender(arg6));
    }

    public fun start_admin_deposit<T0, T1>(arg0: &0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::admin::AdminCap, arg1: &mut 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::async_vault::AsyncVault<T0, T1>, arg2: &mut 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::vault_reserve::VaultReserve<T0, T1>, arg3: &mut 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::SessionFlow<T0, T1>, arg4: &0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::version::Version, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::SessionAsync<T0, T1>) {
        0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::version::assert_current_version(arg4);
        assert!(0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::vault_reserve::value<T0, T1>(arg2) == 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::value<T0, T1>(arg3), 9223372547956015107);
        assert!(0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::kind<T0, T1>(arg3) == 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::move_kind(), 9223372552251375625);
        assert!(0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::async_vault::deposits_open<T0, T1>(arg1), 9223372556545818625);
        0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::allow_consoom<T0, T1>(arg3);
        (0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::vault_reserve::withdraw<T0, T1>(arg2, arg5), 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::create_session<T0, T1>(0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::async_vault::uid<T0, T1>(arg1), 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::value<T0, T1>(arg3), 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::deposit_kind()))
    }

    public fun start_public_deposit<T0, T1>(arg0: &mut 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::async_vault::AsyncVault<T0, T1>, arg1: &mut 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::vault_reserve::VaultReserve<T0, T1>, arg2: &mut 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::SessionFlow<T0, T1>, arg3: &0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::version::Version, arg4: &mut 0x2::tx_context::TxContext) : (0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::SessionAsync<T0, T1>, 0x2::coin::Coin<T0>) {
        0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::version::assert_current_version(arg3);
        assert!(0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::async_vault::deposits_open<T0, T1>(arg0), 9223372200063533057);
        assert!(0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::vault_reserve::value<T0, T1>(arg1) == 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::value<T0, T1>(arg2), 9223372204358631427);
        (0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::create_session<T0, T1>(0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::async_vault::uid<T0, T1>(arg0), 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::value<T0, T1>(arg2), 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::deposit_kind()), 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::vault_reserve::withdraw<T0, T1>(arg1, arg4))
    }

    public fun start_public_withdraw<T0, T1>(arg0: &mut 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::async_vault::AsyncVault<T0, T1>, arg1: &mut 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::SessionFlow<T0, T1>, arg2: &0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::version::Version) : 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::SessionAsync<T0, T1> {
        0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::version::assert_current_version(arg2);
        assert!(0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::kind<T0, T1>(arg1) == 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::withdrawal_kind(), 9223372341797978121);
        assert!(!0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::done<T0, T1>(arg1), 9223372350388043787);
        0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::create_session<T0, T1>(0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::async_vault::uid<T0, T1>(arg0), 0xf290f54a172604fb732d406ffb802e79c3d0657fb624dcc0b89a1869d8ab64b3::session_flow::value<T0, T1>(arg1), 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::withdraw_kind())
    }

    // decompiled from Move bytecode v6
}

