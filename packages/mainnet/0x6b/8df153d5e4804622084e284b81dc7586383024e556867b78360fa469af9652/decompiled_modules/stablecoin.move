module 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::stablecoin {
    struct Stablecoin<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        treasury_cap: 0x2::coin::TreasuryCap<T1>,
        deny_cap: 0x2::coin::DenyCapV2<T1>,
        metadata_cap: 0x2::coin_registry::MetadataCap<T1>,
        valid_recipients: 0x2::table::Table<address, bool>,
    }

    public(friend) fun new<T0, T1>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: 0x2::coin::DenyCapV2<T1>, arg2: 0x2::coin_registry::MetadataCap<T1>, arg3: &mut 0x2::tx_context::TxContext) : Stablecoin<T0, T1> {
        Stablecoin<T0, T1>{
            id               : 0x2::object::new(arg3),
            balance          : 0x2::balance::zero<T0>(),
            treasury_cap     : arg0,
            deny_cap         : arg1,
            metadata_cap     : arg2,
            valid_recipients : 0x2::table::new<address, bool>(arg3),
        }
    }

    public(friend) fun add_valid_mint_recipient<T0, T1>(arg0: &mut Stablecoin<T0, T1>, arg1: address) {
        assert!(!0x2::table::contains<address, bool>(&arg0.valid_recipients, arg1), 13835058416059416577);
        0x2::table::add<address, bool>(&mut arg0.valid_recipients, arg1, true);
    }

    public(friend) fun deny_cap_mut<T0, T1>(arg0: &mut Stablecoin<T0, T1>) : &mut 0x2::coin::DenyCapV2<T1> {
        &mut arg0.deny_cap
    }

    public(friend) fun destroy<T0, T1>(arg0: Stablecoin<T0, T1>) : (0x2::coin::TreasuryCap<T1>, 0x2::coin::DenyCapV2<T1>, 0x2::coin_registry::MetadataCap<T1>) {
        let Stablecoin {
            id               : v0,
            balance          : v1,
            treasury_cap     : v2,
            deny_cap         : v3,
            metadata_cap     : v4,
            valid_recipients : v5,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v1);
        0x2::table::drop<address, bool>(v5);
        (v2, v3, v4)
    }

    public(friend) fun mint_recipient_exists<T0, T1>(arg0: &Stablecoin<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.valid_recipients, arg1)
    }

    public(friend) fun remove_mint_recipient<T0, T1>(arg0: &mut Stablecoin<T0, T1>, arg1: address) {
        assert!(0x2::table::contains<address, bool>(&arg0.valid_recipients, arg1), 13835339946870833155);
        0x2::table::remove<address, bool>(&mut arg0.valid_recipients, arg1);
    }

    public(friend) fun unwrap<T0, T1>(arg0: &mut Stablecoin<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::burn<T1>(&mut arg0.treasury_cap, arg1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, 0x2::coin::value<T1>(&arg1)), arg2)
    }

    public(friend) fun wrap<T0, T1>(arg0: &mut Stablecoin<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        0x2::coin::mint<T1>(&mut arg0.treasury_cap, 0x2::coin::value<T0>(&arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

