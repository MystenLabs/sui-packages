module 0x1f1f5a9b95278d1d5d121226db95c416a23c557a2ee5cd33256c80fb02ef1ae7::purchase_manager {
    struct PURCHASE_MANAGER has drop {
        dummy_field: bool,
    }

    struct PurchaseCertificate has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        purchased_raise_amount: u64,
        protection_raise_limit: u64,
        protection_raise_amount: u64,
        obtained_sale_amount: u64,
        used_raise_amount: u64,
        is_redeemed: bool,
    }

    struct PurchaseInfo has store {
        purchase_certificate_id: 0x2::object::ID,
        purchased_raise_amount: u64,
        protection_raise_limit: u64,
        protection_raise_amount: u64,
        obtained_sale_amount: u64,
        used_raise_amount: u64,
        is_redeemed: bool,
    }

    struct PurchaseManager has store {
        purchases: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<address, PurchaseInfo>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : PurchaseManager {
        PurchaseManager{purchases: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<address, PurchaseInfo>(arg0)}
    }

    public(friend) fun create_purchase_certificate(arg0: &mut PurchaseManager, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : (PurchaseCertificate, 0x2::object::ID) {
        assert!(!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<address, PurchaseInfo>(&arg0.purchases, arg3), 0);
        let v0 = PurchaseCertificate{
            id                      : 0x2::object::new(arg4),
            pool_id                 : arg1,
            purchased_raise_amount  : 0,
            protection_raise_limit  : arg2,
            protection_raise_amount : 0,
            obtained_sale_amount    : 0,
            used_raise_amount       : 0,
            is_redeemed             : false,
        };
        let v1 = PurchaseInfo{
            purchase_certificate_id : 0x2::object::id<PurchaseCertificate>(&v0),
            purchased_raise_amount  : 0,
            protection_raise_limit  : arg2,
            protection_raise_amount : 0,
            obtained_sale_amount    : 0,
            used_raise_amount       : 0,
            is_redeemed             : false,
        };
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<address, PurchaseInfo>(&mut arg0.purchases, arg3, v1);
        (v0, 0x2::object::id<PurchaseCertificate>(&v0))
    }

    public fun info_is_redeemed(arg0: &PurchaseInfo) : bool {
        arg0.is_redeemed
    }

    public fun info_obtained_sale_amount(arg0: &PurchaseInfo) : u64 {
        arg0.obtained_sale_amount
    }

    public fun info_pool_id(arg0: &PurchaseCertificate) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun info_protection_raise_amount(arg0: &PurchaseCertificate) : u64 {
        arg0.protection_raise_amount
    }

    public fun info_protection_raise_limit(arg0: &PurchaseCertificate) : u64 {
        arg0.protection_raise_limit
    }

    public fun info_purchased_raise_amount(arg0: &PurchaseInfo) : u64 {
        arg0.purchased_raise_amount
    }

    public fun info_used_raise_amount(arg0: &PurchaseInfo) : u64 {
        arg0.used_raise_amount
    }

    fun init(arg0: PURCHASE_MANAGER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"<IDO_DEFAULT_NAME>"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://<IDO_DEFAULT_URL>"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https:://<IDO_DEFAULT_IMAGE>"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"<IDO_DEFAULT_DESCRIPTION>"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cetus.zone"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Cetus"));
        let v4 = 0x2::package::claim<PURCHASE_MANAGER>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<PurchaseCertificate>(&v4, v0, v2, arg1);
        0x2::display::update_version<PurchaseCertificate>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<PurchaseCertificate>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun is_redeemed(arg0: &PurchaseCertificate) : bool {
        arg0.is_redeemed
    }

    public fun obtained_sale_amount(arg0: &PurchaseCertificate) : u64 {
        arg0.obtained_sale_amount
    }

    public fun protection_raise_amount(arg0: &PurchaseCertificate) : u64 {
        arg0.protection_raise_amount
    }

    public fun protection_raise_limit(arg0: &PurchaseCertificate) : u64 {
        arg0.protection_raise_limit
    }

    public fun purchased_raise_amount(arg0: &PurchaseCertificate) : u64 {
        arg0.purchased_raise_amount
    }

    public fun refunded_raise_amount(arg0: &PurchaseCertificate) : u64 {
        arg0.purchased_raise_amount - arg0.used_raise_amount
    }

    public fun set_display(arg0: &0x1f1f5a9b95278d1d5d121226db95c416a23c557a2ee5cd33256c80fb02ef1ae7::config::PackageVersion, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        0x1f1f5a9b95278d1d5d121226db95c416a23c557a2ee5cd33256c80fb02ef1ae7::config::checked_package_version(arg0);
        let v0 = 0x1::type_name::get<PURCHASE_MANAGER>();
        assert!(0x1::type_name::get_address(&v0) == *0x2::package::published_package(arg1), 4);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, arg2);
        0x1::vector::push_back<0x1::string::String>(v4, arg4);
        0x1::vector::push_back<0x1::string::String>(v4, arg3);
        0x1::vector::push_back<0x1::string::String>(v4, arg5);
        0x1::vector::push_back<0x1::string::String>(v4, arg6);
        0x1::vector::push_back<0x1::string::String>(v4, arg7);
        let v5 = 0x2::display::new_with_fields<PurchaseCertificate>(arg1, v1, v3, arg8);
        0x2::display::update_version<PurchaseCertificate>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<PurchaseCertificate>>(v5, 0x2::tx_context::sender(arg8));
    }

    public fun total_count(arg0: &PurchaseManager) : u64 {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::length<address, PurchaseInfo>(&arg0.purchases)
    }

    public(friend) fun transfer_purchase_certificate_to(arg0: &PurchaseManager, arg1: PurchaseCertificate, arg2: address) {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<address, PurchaseInfo>(&arg0.purchases, arg2), 1);
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<address, PurchaseInfo>(&arg0.purchases, arg2).purchase_certificate_id == 0x2::object::id<PurchaseCertificate>(&arg1), 3);
        0x2::transfer::transfer<PurchaseCertificate>(arg1, arg2);
    }

    public(friend) fun update_for_purchase(arg0: &mut PurchaseManager, arg1: &mut PurchaseCertificate, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) : u64 {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<address, PurchaseInfo>(&arg0.purchases, 0x2::tx_context::sender(arg4)), 1);
        assert!(arg2 > 0, 2);
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<address, PurchaseInfo>(&mut arg0.purchases, 0x2::tx_context::sender(arg4));
        let v1 = if (v0.protection_raise_limit <= v0.protection_raise_amount) {
            0
        } else {
            let v2 = v0.protection_raise_limit - v0.protection_raise_amount;
            if (v2 > arg3) {
                arg3
            } else {
                v2
            }
        };
        let v3 = if (v1 >= arg2) {
            arg2
        } else {
            v1
        };
        v0.purchased_raise_amount = arg1.purchased_raise_amount + arg2;
        v0.protection_raise_amount = arg1.protection_raise_amount + v3;
        arg1.purchased_raise_amount = v0.purchased_raise_amount;
        arg1.protection_raise_amount = v0.protection_raise_amount;
        v3
    }

    public(friend) fun update_for_redeem(arg0: &mut PurchaseManager, arg1: &mut PurchaseCertificate, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<address, PurchaseInfo>(&arg0.purchases, 0x2::tx_context::sender(arg4)), 1);
        arg1.obtained_sale_amount = arg2;
        arg1.used_raise_amount = arg3;
        arg1.is_redeemed = true;
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<address, PurchaseInfo>(&mut arg0.purchases, 0x2::tx_context::sender(arg4));
        v0.obtained_sale_amount = arg1.obtained_sale_amount;
        v0.used_raise_amount = arg1.used_raise_amount;
        v0.is_redeemed = arg1.is_redeemed;
    }

    public fun used_raise_amount(arg0: &PurchaseCertificate) : u64 {
        arg0.used_raise_amount
    }

    // decompiled from Move bytecode v6
}

