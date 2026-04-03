module 0xf2bcf3b10db2adf42b6e09a45e29aee96b5f135de588d013188dfd893a9c6a99::liquidator {
    struct LIQUIDATOR has drop {
        dummy_field: bool,
    }

    struct LiquidatorAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Liquidator has store, key {
        id: 0x2::object::UID,
        package_caller_cap: 0x1::option::Option<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::PackageCallerCap>,
        whitelist: 0x2::vec_set::VecSet<address>,
        recipient: 0x1::option::Option<address>,
        package_whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct LiquidatorUpdated has copy, drop {
        who: address,
        is_remove: bool,
    }

    struct PackageCallerCapPopulated has copy, drop {
        had_previous_cap: bool,
    }

    struct RecipientUpdated has copy, drop {
        had_previous: bool,
        old_recipient: address,
        new_recipient: address,
    }

    struct PackageWhitelistUpdated has copy, drop {
        package_type: 0x1::type_name::TypeName,
        is_remove: bool,
    }

    public(friend) fun borrow_package_caller_cap(arg0: &Liquidator) : &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::PackageCallerCap {
        0x1::option::borrow<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::PackageCallerCap>(&arg0.package_caller_cap)
    }

    public(friend) fun ensure_caller_whitelisted(arg0: &Liquidator, arg1: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.whitelist, &arg1), 0xf2bcf3b10db2adf42b6e09a45e29aee96b5f135de588d013188dfd893a9c6a99::error::not_whitelisted());
    }

    public fun get_recipient(arg0: &Liquidator) : address {
        *0x1::option::borrow<address>(&arg0.recipient)
    }

    fun init(arg0: LIQUIDATOR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<LIQUIDATOR>(arg0, arg1);
        let v0 = LiquidatorAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<LiquidatorAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Liquidator{
            id                 : 0x2::object::new(arg1),
            package_caller_cap : 0x1::option::none<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::PackageCallerCap>(),
            whitelist          : 0x2::vec_set::empty<address>(),
            recipient          : 0x1::option::none<address>(),
            package_whitelist  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::public_share_object<Liquidator>(v1);
    }

    public(friend) fun is_package_whitelisted<T0: drop>(arg0: &Liquidator) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.package_whitelist, &v0)
    }

    public fun is_whitelisted(arg0: &Liquidator, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.whitelist, &arg1)
    }

    public fun populate_package_caller_cap(arg0: &LiquidatorAdminCap, arg1: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut Liquidator, arg3: 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::PackageCallerCap) {
        let v0 = 0x1::option::is_some<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::PackageCallerCap>(&arg2.package_caller_cap);
        if (v0) {
            0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::whitelist_admin::burn_whitelist(arg1, 0x1::option::extract<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::PackageCallerCap>(&mut arg2.package_caller_cap));
        };
        0x1::option::fill<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::PackageCallerCap>(&mut arg2.package_caller_cap, arg3);
        let v1 = PackageCallerCapPopulated{had_previous_cap: v0};
        0x2::event::emit<PackageCallerCapPopulated>(v1);
    }

    public(friend) fun transfer_to_recipient<T0>(arg0: &Liquidator, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, *0x1::option::borrow<address>(&arg0.recipient));
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
    }

    public fun update_package_whitelist<T0: drop>(arg0: &LiquidatorAdminCap, arg1: &mut Liquidator, arg2: bool) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (arg2) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.package_whitelist, &v0);
        } else {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.package_whitelist, v0);
        };
        let v1 = PackageWhitelistUpdated{
            package_type : v0,
            is_remove    : arg2,
        };
        0x2::event::emit<PackageWhitelistUpdated>(v1);
    }

    public fun update_recipient(arg0: &LiquidatorAdminCap, arg1: &mut Liquidator, arg2: address) {
        let v0 = 0x1::option::is_some<address>(&arg1.recipient);
        let v1 = if (v0) {
            *0x1::option::borrow<address>(&arg1.recipient)
        } else {
            @0x0
        };
        arg1.recipient = 0x1::option::some<address>(arg2);
        let v2 = RecipientUpdated{
            had_previous  : v0,
            old_recipient : v1,
            new_recipient : arg2,
        };
        0x2::event::emit<RecipientUpdated>(v2);
    }

    public fun update_whitelist(arg0: &LiquidatorAdminCap, arg1: &mut Liquidator, arg2: address, arg3: bool) {
        if (arg3) {
            0x2::vec_set::remove<address>(&mut arg1.whitelist, &arg2);
        } else {
            0x2::vec_set::insert<address>(&mut arg1.whitelist, arg2);
        };
        let v0 = LiquidatorUpdated{
            who       : arg2,
            is_remove : arg3,
        };
        0x2::event::emit<LiquidatorUpdated>(v0);
    }

    public fun whitelisted(arg0: &Liquidator) : vector<address> {
        0x2::vec_set::into_keys<address>(arg0.whitelist)
    }

    // decompiled from Move bytecode v6
}

