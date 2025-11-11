module 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::functions_burn_for_redemption {
    public fun burn_for_redemption<T0>(arg0: &mut 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::Root, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::coin::Coin<T0>, arg3: 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_redemption::Redemption, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_redemption::get_amount(&arg3) > 0, 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::errors::e_insufficient_amount());
        let v1 = 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::functions_create_redemption_request_id::create_redemption_request_id(0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_redemption::get_asset(&arg3), 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_redemption::get_chain(&arg3), 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_redemption::get_redemption_id(&arg3));
        let v2 = 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::borrow_redemption_registry_mut(arg0);
        assert!(!0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::functions_redemption_request_exists::redemption_request_exists(v2, v1), 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::errors::e_redemption_request_exists());
        0x2::table::add<0x1::string::String, bool>(0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_redemption_registry::borrow_processed_redemptions(v2), v1, true);
        0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_redemption_registry::increment_total_burned_by(v2, 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_redemption::get_amount(&arg3));
        0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_redemption_registry::increment_redemption_count_by(v2, 1);
        0x2::coin::burn<T0>(arg1, 0x2::coin::split<T0>(arg2, 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_redemption::get_amount(&arg3), arg4));
        let v3 = 0x2::coin::total_supply<T0>(arg1);
        0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::events_burn_for_redemption::emit_burn_for_redemption_event(v1, 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_redemption::get_asset(&arg3), 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_redemption::get_chain(&arg3), 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_redemption::get_amount(&arg3), v0, v3);
        0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::events_burn::emit_burn_event(0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_redemption::get_amount(&arg3), v0, v3);
    }

    // decompiled from Move bytecode v6
}

