module 0x600641ed27417a9524b72dc2860b765f677e7de7ed9f9b528b03f5be22d2165b::hav {
    struct HAV has drop {
        dummy_field: bool,
    }

    struct MetadataAdmin has key {
        id: 0x2::object::UID,
        admin: address,
        pending_admin: 0x1::option::Option<address>,
        cap: 0x2::coin_registry::MetadataCap<HAV>,
    }

    struct NameUpdated has copy, drop {
        name: 0x1::string::String,
    }

    struct DescriptionUpdated has copy, drop {
        description: 0x1::string::String,
    }

    struct IconUrlUpdated has copy, drop {
        icon_url: 0x1::string::String,
    }

    struct AdminTransferRequested has copy, drop {
        from: address,
        to: address,
    }

    struct AdminTransferCanceled has copy, drop {
        admin: address,
    }

    struct AdminTransferred has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct Burned has copy, drop {
        amount: u64,
    }

    public fun burn(arg0: &mut 0x2::coin_registry::Currency<HAV>, arg1: 0x2::coin::Coin<HAV>) {
        let v0 = Burned{amount: 0x2::coin::value<HAV>(&arg1)};
        0x2::event::emit<Burned>(v0);
        0x2::coin_registry::burn<HAV>(arg0, arg1);
    }

    public fun accept_admin_transfer(arg0: &mut MetadataAdmin, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::option::contains<address>(&arg0.pending_admin, &v0), 13835340350598086664);
        arg0.admin = 0x2::tx_context::sender(arg1);
        arg0.pending_admin = 0x1::option::none<address>();
        let v1 = AdminTransferred{
            old_admin : arg0.admin,
            new_admin : arg0.admin,
        };
        0x2::event::emit<AdminTransferred>(v1);
    }

    public fun admin(arg0: &MetadataAdmin) : address {
        arg0.admin
    }

    public fun begin_admin_transfer(arg0: &mut MetadataAdmin, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 13835058811196735494);
        assert!(arg1 != @0x0 && arg1 != arg0.admin, 13836184715399069710);
        arg0.pending_admin = 0x1::option::some<address>(arg1);
        let v0 = AdminTransferRequested{
            from : arg0.admin,
            to   : arg1,
        };
        0x2::event::emit<AdminTransferRequested>(v0);
    }

    public fun cancel_admin_transfer(arg0: &mut MetadataAdmin, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 13835058845556473862);
        arg0.pending_admin = 0x1::option::none<address>();
        let v0 = AdminTransferCanceled{admin: arg0.admin};
        0x2::event::emit<AdminTransferCanceled>(v0);
    }

    fun init(arg0: HAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<HAV>(arg0, 9, 0x1::string::utf8(b"HAV"), 0x1::string::utf8(b"Havenex Token"), 0x1::string::utf8(b"Havenex Token"), 0x1::string::utf8(b"https://icon.havenag.com/icon.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<HAV>>(0x2::coin::mint<HAV>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::coin_registry::make_supply_burn_only_init<HAV>(&mut v3, v2);
        let v4 = MetadataAdmin{
            id            : 0x2::object::new(arg1),
            admin         : 0x2::tx_context::sender(arg1),
            pending_admin : 0x1::option::none<address>(),
            cap           : 0x2::coin_registry::finalize<HAV>(v3, arg1),
        };
        0x2::transfer::share_object<MetadataAdmin>(v4);
    }

    public fun pending_admin(arg0: &MetadataAdmin) : 0x1::option::Option<address> {
        arg0.pending_admin
    }

    public fun update_description(arg0: &MetadataAdmin, arg1: &mut 0x2::coin_registry::Currency<HAV>, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 13835058703822553094);
        assert!(0x1::string::length(&arg2) <= 512, 13835903133048045580);
        0x2::coin_registry::set_description<HAV>(arg1, &arg0.cap, arg2);
        let v0 = DescriptionUpdated{description: arg2};
        0x2::event::emit<DescriptionUpdated>(v0);
    }

    public fun update_icon_url(arg0: &MetadataAdmin, arg1: &mut 0x2::coin_registry::Currency<HAV>, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 13835058759657127942);
        assert!(0x1::string::length(&arg2) <= 256, 13835903188882620428);
        0x2::coin_registry::set_icon_url<HAV>(arg1, &arg0.cap, arg2);
        let v0 = IconUrlUpdated{icon_url: arg2};
        0x2::event::emit<IconUrlUpdated>(v0);
    }

    public fun update_name(arg0: &MetadataAdmin, arg1: &mut 0x2::coin_registry::Currency<HAV>, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 13835058643693010950);
        assert!(!0x1::string::is_empty(&arg2), 13835621597941661706);
        assert!(0x1::string::length(&arg2) <= 64, 13835903077213470732);
        0x2::coin_registry::set_name<HAV>(arg1, &arg0.cap, arg2);
        let v0 = NameUpdated{name: arg2};
        0x2::event::emit<NameUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

