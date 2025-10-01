module 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_royalty_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        amount_bp: u16,
    }

    struct RoyaltyRequest {
        royalty: u64,
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: &0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::Admins, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::is_admin(arg2, &v0), 13906834311782334465);
        let v1 = Rule{dummy_field: false};
        let v2 = Config{amount_bp: 0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::get_aount_bp(arg2)};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v1, arg0, arg1, v2);
    }

    public fun calculate<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : RoyaltyRequest {
        RoyaltyRequest{royalty: get_royalty<T0>(arg0, arg1)}
    }

    public fun get(arg0: &RoyaltyRequest) : u64 {
        arg0.royalty
    }

    public fun get_royalty<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : u64 {
        let v0 = Rule{dummy_field: false};
        (((0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0).amount_bp as u128) * (arg1 as u128) / (0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::max_bp() as u128)) as u64)
    }

    public fun handle<T0, T1>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: RoyaltyRequest, arg3: 0x2::coin::Coin<T1>) {
        let RoyaltyRequest {  } = arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, 0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::royality_address());
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v0, arg1);
    }

    public fun handle_burn<T0>(arg0: &0x2::kiosk::KioskOwnerCap, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v0, arg1);
    }

    public fun remove<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: &0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::Admins, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::is_admin(arg2, &v0), 13906834380501811201);
        0x2::transfer_policy::remove_rule<T0, Rule, Config>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

