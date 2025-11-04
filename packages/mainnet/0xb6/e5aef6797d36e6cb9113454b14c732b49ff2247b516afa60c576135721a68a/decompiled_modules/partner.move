module 0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::partner {
    struct PARTNER has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct PartnerCap has key {
        id: 0x2::object::UID,
        level: u8,
    }

    struct ProtocolFeeBag has key {
        id: 0x2::object::UID,
        balance_bag: 0x2::bag::Bag,
    }

    public(friend) fun charge_fee<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut ProtocolFeeBag, arg2: &PartnerCap, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 100, 0);
        let v0 = 0x2::balance::value<T0>(arg0) * arg3 / 10000;
        let v1 = 0x2::balance::split<T0>(arg0, v0);
        if (arg2.level == 2) {
            put_balance_in_bag<T0>(arg1, 0x2::balance::split<T0>(&mut v1, v0 * 2000 / 10000));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg5), arg4);
    }

    public fun claim_protocol_fee<T0>(arg0: &AdminCap, arg1: &mut ProtocolFeeBag, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = BalanceKey<T0>{dummy_field: false};
        0x2::coin::from_balance<T0>(0x2::bag::remove<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg1.balance_bag, v0), arg2)
    }

    public fun get_partner_level(arg0: u8) : u8 {
        let v0 = &arg0;
        if (*v0 == 0) {
            0
        } else if (*v0 == 1) {
            1
        } else if (*v0 == 2) {
            2
        } else {
            2
        }
    }

    fun init(arg0: PARTNER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = PartnerCap{
            id    : 0x2::object::new(arg1),
            level : 2,
        };
        let v2 = PartnerCap{
            id    : 0x2::object::new(arg1),
            level : 1,
        };
        let v3 = PartnerCap{
            id    : 0x2::object::new(arg1),
            level : 0,
        };
        let v4 = ProtocolFeeBag{
            id          : 0x2::object::new(arg1),
            balance_bag : 0x2::bag::new(arg1),
        };
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<PartnerCap>(v1);
        0x2::transfer::share_object<PartnerCap>(v2);
        0x2::transfer::share_object<PartnerCap>(v3);
        0x2::transfer::share_object<ProtocolFeeBag>(v4);
    }

    entry fun mint_partner_cap(arg0: &AdminCap, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PartnerCap{
            id    : 0x2::object::new(arg2),
            level : get_partner_level(arg1),
        };
        0x2::transfer::share_object<PartnerCap>(v0);
    }

    fun put_balance_in_bag<T0>(arg0: &mut ProtocolFeeBag, arg1: 0x2::balance::Balance<T0>) {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balance_bag, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balance_bag, v0), arg1);
        } else {
            0x2::bag::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balance_bag, v0, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

