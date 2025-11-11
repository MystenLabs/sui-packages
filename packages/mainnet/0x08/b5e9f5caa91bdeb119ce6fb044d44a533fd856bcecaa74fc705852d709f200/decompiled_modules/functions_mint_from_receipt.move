module 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::functions_mint_from_receipt {
    public fun mint_from_receipt<T0>(arg0: &mut 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::Root, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt::Receipt, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::functions_create_receipt_id::create_receipt_id(0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt::get_asset(&arg2), 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt::get_chain(&arg2), 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt::get_tx_id(&arg2));
        let v1 = 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_root::borrow_receipt_registry_mut(arg0);
        assert!(!0x2::table::contains<0x1::string::String, bool>(0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt_registry::get_used_receipts(v1), v0), 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::errors::e_receipt_already_used());
        assert!(0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt::get_amount(&arg2) > 0, 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::errors::e_insufficient_amount());
        0x2::table::add<0x1::string::String, bool>(0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt_registry::borrow_used_receipts(v1), v0, true);
        0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt_registry::increment_total_minted_by(v1, 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt::get_amount(&arg2));
        0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt_registry::increment_receipt_count_by(v1, 1);
        0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::events_mint_from_receipt::emit_mint_from_receipt_event(v0, 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt::get_asset(&arg2), 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt::get_chain(&arg2), 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt::get_tx_id(&arg2), 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt::get_amount(&arg2), 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt::get_recipient(&arg2), 0x2::tx_context::sender(arg3), 0x2::coin::total_supply<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(arg1, 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt::get_amount(&arg2), arg3), 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_receipt::get_recipient(&arg2));
    }

    // decompiled from Move bytecode v6
}

