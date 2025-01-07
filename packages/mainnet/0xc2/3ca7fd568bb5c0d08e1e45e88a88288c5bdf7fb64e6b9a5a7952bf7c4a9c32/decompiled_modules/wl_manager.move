module 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::wl_manager {
    struct WhitelistManager<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        private_sale_price: u64,
        public_sale_price: u64,
        payments: 0x2::balance::Balance<0x2::sui::SUI>,
        public_sale_caps: 0x2::table_vec::TableVec<0x2::kiosk::PurchaseCap<T0>>,
    }

    public fun add_cap_for_public_sale<T0: store + key>(arg0: &0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::egg::EggCollectionInfo, arg1: &mut WhitelistManager<T0>, arg2: 0x2::kiosk::PurchaseCap<T0>) {
        0x2::table_vec::push_back<0x2::kiosk::PurchaseCap<T0>>(&mut arg1.public_sale_caps, arg2);
    }

    public fun add_cap_to_whitelisted_address<T0: store + key>(arg0: &0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::egg::EggCollectionInfo, arg1: &mut WhitelistManager<T0>, arg2: 0x2::kiosk::PurchaseCap<T0>, arg3: address) {
        if (0x2::dynamic_field::exists_<0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::keys::EggWhitelist>(&arg1.id, 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::keys::egg_whitelist(arg3))) {
            0x1::vector::push_back<0x2::kiosk::PurchaseCap<T0>>(0x2::dynamic_field::borrow_mut<0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::keys::EggWhitelist, vector<0x2::kiosk::PurchaseCap<T0>>>(&mut arg1.id, 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::keys::egg_whitelist(arg3)), arg2);
        } else {
            0x2::dynamic_field::add<0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::keys::EggWhitelist, vector<0x2::kiosk::PurchaseCap<T0>>>(&mut arg1.id, 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::keys::egg_whitelist(arg3), 0x1::vector::singleton<0x2::kiosk::PurchaseCap<T0>>(arg2));
        };
        0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::events::emit_added_to_whitelist(arg3);
    }

    fun assert_address_has_remaining_purchase_cap(arg0: u64) {
        assert!(arg0 > 0, 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::errors::no_caps_remaining_for_address());
    }

    fun assert_address_is_whitelisted<T0: store + key>(arg0: &WhitelistManager<T0>, arg1: address) {
        assert!(0x2::dynamic_field::exists_<0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::keys::EggWhitelist>(&arg0.id, 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::keys::egg_whitelist(arg1)), 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::errors::address_not_whitelisted());
    }

    fun assert_correct_payment(arg0: u64, arg1: u64) {
        assert!(arg0 == arg1, 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::errors::invalid_payment());
    }

    fun assert_remaining_purchase_caps_for_public_sale<T0: store + key>(arg0: &WhitelistManager<T0>) {
        assert!(remaining_public_sale_caps<T0>(arg0) > 0, 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::errors::no_caps_remaining_for_public_sale());
    }

    public fun caps_for_address<T0: store + key>(arg0: &WhitelistManager<T0>, arg1: address) : &vector<0x2::kiosk::PurchaseCap<T0>> {
        0x2::dynamic_field::borrow<0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::keys::EggWhitelist, vector<0x2::kiosk::PurchaseCap<T0>>>(&arg0.id, 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::keys::egg_whitelist(arg1))
    }

    public fun create_whitelist_manager<T0: store + key>(arg0: &0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::egg::EggCollectionInfo, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = WhitelistManager<T0>{
            id                 : 0x2::object::new(arg1),
            private_sale_price : 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::constants::private_sale_price(),
            public_sale_price  : 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::constants::public_sale_price(),
            payments           : 0x2::balance::zero<0x2::sui::SUI>(),
            public_sale_caps   : 0x2::table_vec::empty<0x2::kiosk::PurchaseCap<T0>>(arg1),
        };
        0x2::transfer::public_share_object<WhitelistManager<T0>>(v0);
    }

    public fun is_whitelisted<T0: store + key>(arg0: &WhitelistManager<T0>, arg1: address) : bool {
        0x2::dynamic_field::exists_<0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::keys::EggWhitelist>(&arg0.id, 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::keys::egg_whitelist(arg1))
    }

    public fun public_sale_purchase<T0: store + key>(arg0: &mut WhitelistManager<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::kiosk::PurchaseCap<T0> {
        assert_remaining_purchase_caps_for_public_sale<T0>(arg0);
        assert_correct_payment(0x2::coin::value<0x2::sui::SUI>(&arg1), arg0.public_sale_price);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.payments, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::events::emit_completed_public_sale_purchase(0x2::tx_context::sender(arg2));
        0x2::table_vec::pop_back<0x2::kiosk::PurchaseCap<T0>>(&mut arg0.public_sale_caps)
    }

    public fun remaining_public_sale_caps<T0: store + key>(arg0: &WhitelistManager<T0>) : u64 {
        0x2::table_vec::length<0x2::kiosk::PurchaseCap<T0>>(&arg0.public_sale_caps)
    }

    public fun remove_cap_for_public_sale<T0: store + key>(arg0: &0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::egg::EggCollectionInfo, arg1: &mut WhitelistManager<T0>) : 0x2::kiosk::PurchaseCap<T0> {
        0x2::table_vec::pop_back<0x2::kiosk::PurchaseCap<T0>>(&mut arg1.public_sale_caps)
    }

    public fun remove_cap_from_whitelisted_address<T0: store + key>(arg0: &0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::egg::EggCollectionInfo, arg1: &mut WhitelistManager<T0>, arg2: address) : 0x2::kiosk::PurchaseCap<T0> {
        assert_address_is_whitelisted<T0>(arg1, arg2);
        let v0 = 0x2::dynamic_field::borrow_mut<0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::keys::EggWhitelist, vector<0x2::kiosk::PurchaseCap<T0>>>(&mut arg1.id, 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::keys::egg_whitelist(arg2));
        assert_address_has_remaining_purchase_cap(0x1::vector::length<0x2::kiosk::PurchaseCap<T0>>(v0));
        0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::events::emit_removed_from_whitelist(arg2);
        0x1::vector::pop_back<0x2::kiosk::PurchaseCap<T0>>(v0)
    }

    public fun whitelist_purchase<T0: store + key>(arg0: &mut WhitelistManager<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::kiosk::PurchaseCap<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_address_is_whitelisted<T0>(arg0, v0);
        assert_correct_payment(0x2::coin::value<0x2::sui::SUI>(&arg1), arg0.private_sale_price);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.payments, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = 0x2::dynamic_field::remove<0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::keys::EggWhitelist, vector<0x2::kiosk::PurchaseCap<T0>>>(&mut arg0.id, 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::keys::egg_whitelist(v0));
        assert_address_has_remaining_purchase_cap(0x1::vector::length<0x2::kiosk::PurchaseCap<T0>>(&v1));
        0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::events::emit_completed_whitelist_purchase(v0);
        if (0x1::vector::length<0x2::kiosk::PurchaseCap<T0>>(&v1) > 0) {
            0x2::dynamic_field::add<0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::keys::EggWhitelist, vector<0x2::kiosk::PurchaseCap<T0>>>(&mut arg0.id, 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::keys::egg_whitelist(v0), v1);
        } else {
            0x1::vector::destroy_empty<0x2::kiosk::PurchaseCap<T0>>(v1);
        };
        0x1::vector::pop_back<0x2::kiosk::PurchaseCap<T0>>(&mut v1)
    }

    public fun withdraw_profits<T0: store + key>(arg0: &0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::egg::EggCollectionInfo, arg1: &mut WhitelistManager<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.payments);
        assert!(v0 != 0, 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::errors::insufficient_amount());
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.payments, v0), arg2)
    }

    // decompiled from Move bytecode v6
}

