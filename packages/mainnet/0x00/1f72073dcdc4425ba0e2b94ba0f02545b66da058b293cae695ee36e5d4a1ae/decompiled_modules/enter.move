module 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::enter {
    public entry fun create_account<T0>(arg0: &0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::create_account<T0>(arg0, arg1);
    }

    public entry fun deposit<T0>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T0>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg1);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::deposit<T0>(arg0, v0, arg2, arg3);
    }

    public entry fun withdrawal<T0, T1>(arg0: &0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::MarketList, arg1: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>, arg2: &0x63f930881f4207460a67846db62bc89a82d87570a3dc2bedb546b30bd4c6ff19::oracle::Root, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::withdrawal<T0, T1>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::position::get_equity<T0, T1>(arg0, arg1, arg2), arg1, arg3, arg4);
    }

    public entry fun add_admin_member(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::ScaleAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::add_admin_member(arg0, arg1, arg2);
    }

    public entry fun remove_admin_member(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::ScaleAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::remove_admin_member(arg0, arg1, arg2);
    }

    public entry fun add_factory_mould(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::AdminCap, arg1: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::bond::ScaleNFTFactory, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::bond::add_factory_mould(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun divestment<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::MarketList, arg1: 0x2::object::ID, arg2: 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::bond::ScaleBond<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::bond::divestment<T0, T1>(0x2::dynamic_object_field::borrow_mut<0x2::object::ID, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_list_uid_mut(arg0), arg1), arg2, 0x1::option::none<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::bond::MoveToken>(), arg3);
    }

    public entry fun divestment_by_upgrade<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::MarketList, arg1: 0x2::object::ID, arg2: 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::bond::ScaleBond<T0, T1>, arg3: 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::bond::UpgradeMoveToken, arg4: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::bond::divestment_by_upgrade<T0, T1>(0x2::dynamic_object_field::borrow_mut<0x2::object::ID, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_list_uid_mut(arg0), arg1), arg2, arg3, arg4);
    }

    public entry fun generate_upgrade_move_token<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::AdminCap, arg1: &0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::bond::ScaleBond<T0, T1>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::bond::generate_upgrade_move_token<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun investment<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::MarketList, arg1: 0x2::object::ID, arg2: vector<0x2::coin::Coin<T1>>, arg3: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::bond::ScaleNFTFactory, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T1>>(&mut arg2);
        0x2::pay::join_vec<T1>(&mut v0, arg2);
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::bond::investment<T0, T1>(0x2::dynamic_object_field::borrow_mut<0x2::object::ID, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_list_uid_mut(arg0), arg1), v0, arg3, arg4, arg5, arg6);
    }

    public entry fun remove_factory_mould(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::AdminCap, arg1: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::bond::ScaleNFTFactory, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::bond::remove_factory_mould(arg0, arg1, arg2, arg3);
    }

    public entry fun burst_position<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::MarketList, arg1: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>, arg2: &0x63f930881f4207460a67846db62bc89a82d87570a3dc2bedb546b30bd4c6ff19::oracle::Root, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::position::burst_position<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun close_position<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::MarketList, arg1: 0x2::object::ID, arg2: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>, arg3: &0x63f930881f4207460a67846db62bc89a82d87570a3dc2bedb546b30bd4c6ff19::oracle::Root, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::position::close_position<T0, T1>(0x2::dynamic_object_field::borrow_mut<0x2::object::ID, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_list_uid_mut(arg0), arg1), arg2, arg3, arg4, arg5);
    }

    public entry fun create_market<T0>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::MarketList, arg1: &0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::create_market<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun open_position<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::MarketList, arg1: 0x2::object::ID, arg2: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account::Account<T1>, arg3: &0x63f930881f4207460a67846db62bc89a82d87570a3dc2bedb546b30bd4c6ff19::oracle::Root, arg4: u64, arg5: u8, arg6: u8, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::position::open_position<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun trigger_update_opening_price<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::MarketList, arg1: 0x2::object::ID, arg2: &0x63f930881f4207460a67846db62bc89a82d87570a3dc2bedb546b30bd4c6ff19::oracle::Root, arg3: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::trigger_update_opening_price<T0, T1>(0x2::dynamic_object_field::borrow_mut<0x2::object::ID, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_list_uid_mut(arg0), arg1), arg2, arg3);
    }

    public entry fun update_description<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::ScaleAdminCap, arg1: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::MarketList, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::update_description<T0, T1>(arg0, 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_list_uid_mut(arg1), arg2), arg3, arg4);
    }

    public entry fun update_fund_fee<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::ScaleAdminCap, arg1: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::MarketList, arg2: 0x2::object::ID, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::update_fund_fee<T0, T1>(arg0, 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_list_uid_mut(arg1), arg2), arg3, arg4, arg5);
    }

    public entry fun update_icon<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::ScaleAdminCap, arg1: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::MarketList, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::update_icon<T0, T1>(arg0, 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_list_uid_mut(arg1), arg2), arg3, arg4);
    }

    public entry fun update_insurance_fee<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::ScaleAdminCap, arg1: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::MarketList, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::update_insurance_fee<T0, T1>(arg0, 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_list_uid_mut(arg1), arg2), arg3, arg4);
    }

    public entry fun update_margin_fee<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::ScaleAdminCap, arg1: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::MarketList, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::update_margin_fee<T0, T1>(arg0, 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_list_uid_mut(arg1), arg2), arg3, arg4);
    }

    public entry fun update_max_leverage<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::ScaleAdminCap, arg1: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::MarketList, arg2: 0x2::object::ID, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::update_max_leverage<T0, T1>(arg0, 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_list_uid_mut(arg1), arg2), arg3, arg4);
    }

    public entry fun update_officer<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::AdminCap, arg1: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::MarketList, arg2: 0x2::object::ID, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::update_officer<T0, T1>(arg0, 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_list_uid_mut(arg1), arg2), arg3, arg4);
    }

    public entry fun update_spread_fee<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::ScaleAdminCap, arg1: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::MarketList, arg2: 0x2::object::ID, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::update_spread_fee<T0, T1>(arg0, 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_list_uid_mut(arg1), arg2), arg3, arg4, arg5);
    }

    public entry fun update_status<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::ScaleAdminCap, arg1: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::MarketList, arg2: 0x2::object::ID, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::update_status<T0, T1>(arg0, 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::Market<T0, T1>>(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market::get_list_uid_mut(arg1), arg2), arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

