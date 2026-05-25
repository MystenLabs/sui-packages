module 0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::tapp_card {
    struct CardSpendingCap<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
        daily_limit_subunit: u64,
        spent_today_subunit: u64,
        day_index: u64,
        per_tap_limit_subunit: u64,
        card_uid_hash: vector<u8>,
        revoked: bool,
    }

    public fun balance_value<T0>(arg0: &CardSpendingCap<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun card_uid_hash<T0>(arg0: &CardSpendingCap<T0>) : &vector<u8> {
        &arg0.card_uid_hash
    }

    public entry fun create_cap<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 8);
        assert!(arg1 >= arg2, 8);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 7);
        let v0 = CardSpendingCap<T0>{
            id                    : 0x2::object::new(arg4),
            owner                 : 0x2::tx_context::sender(arg4),
            balance               : 0x2::coin::into_balance<T0>(arg0),
            daily_limit_subunit   : arg1,
            spent_today_subunit   : 0,
            day_index             : 0,
            per_tap_limit_subunit : arg2,
            card_uid_hash         : arg3,
            revoked               : false,
        };
        0x2::transfer::share_object<CardSpendingCap<T0>>(v0);
    }

    public fun daily_limit<T0>(arg0: &CardSpendingCap<T0>) : u64 {
        arg0.daily_limit_subunit
    }

    public fun day_index<T0>(arg0: &CardSpendingCap<T0>) : u64 {
        arg0.day_index
    }

    public entry fun debit<T0>(arg0: &0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::config::AggregatorCap, arg1: &mut CardSpendingCap<T0>, arg2: u64, arg3: address, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.revoked, 2);
        assert!(arg2 > 0, 5);
        assert!(arg2 <= arg1.per_tap_limit_subunit, 3);
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 6);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = v0 / 86400000;
        if (v1 != arg1.day_index) {
            arg1.day_index = v1;
            arg1.spent_today_subunit = 0;
        };
        assert!(arg1.spent_today_subunit + arg2 <= arg1.daily_limit_subunit, 4);
        arg1.spent_today_subunit = arg1.spent_today_subunit + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg6), arg3);
        0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::events::emit_card_debited(0x2::object::id<CardSpendingCap<T0>>(arg1), arg1.owner, arg3, arg2, arg4, v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())));
    }

    public entry fun destroy_and_reclaim<T0>(arg0: CardSpendingCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
        let CardSpendingCap {
            id                    : v0,
            owner                 : v1,
            balance               : v2,
            daily_limit_subunit   : _,
            spent_today_subunit   : _,
            day_index             : _,
            per_tap_limit_subunit : _,
            card_uid_hash         : _,
            revoked               : _,
        } = arg0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg1), v1);
        0x2::object::delete(v0);
    }

    public fun is_revoked<T0>(arg0: &CardSpendingCap<T0>) : bool {
        arg0.revoked
    }

    public fun owner<T0>(arg0: &CardSpendingCap<T0>) : address {
        arg0.owner
    }

    public fun per_tap_limit<T0>(arg0: &CardSpendingCap<T0>) : u64 {
        arg0.per_tap_limit_subunit
    }

    public entry fun set_revoked<T0>(arg0: &mut CardSpendingCap<T0>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        arg0.revoked = arg1;
    }

    public fun spent_today<T0>(arg0: &CardSpendingCap<T0>) : u64 {
        arg0.spent_today_subunit
    }

    public entry fun top_up<T0>(arg0: &mut CardSpendingCap<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun update_limits<T0>(arg0: &mut CardSpendingCap<T0>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(arg2 > 0, 8);
        assert!(arg1 >= arg2, 8);
        arg0.daily_limit_subunit = arg1;
        arg0.per_tap_limit_subunit = arg2;
    }

    // decompiled from Move bytecode v7
}

