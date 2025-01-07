module 0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::subscription {
    struct CollectorCap has store, key {
        id: 0x2::object::UID,
    }

    struct Subscription has store, key {
        id: 0x2::object::UID,
        subscribers: 0x2::bag::Bag,
    }

    struct CollectorUpdated has copy, drop, store {
        new_collector: address,
    }

    struct Payment has copy, drop, store {
        payment_info: 0x1::ascii::String,
        amount: u64,
    }

    public entry fun collect<T0>(arg0: &CollectorCap, arg1: &mut Subscription, arg2: &mut 0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::fee::FeeManager, arg3: &mut 0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::bank::Bank, arg4: 0x1::ascii::String, arg5: &mut 0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::slot::Slot, arg6: u64, arg7: u64, arg8: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::bag::contains<address>(&arg1.subscribers, 0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::slot::get_owner(arg5)), 0);
        if (0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::slot::balance<T0>(arg5) < arg6) {
            0x2::bag::remove<address, bool>(&mut arg1.subscribers, 0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::slot::get_owner(arg5));
            return
        };
        let v0 = 0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::blue_move_protocol::swap_exact_input<T0, 0x2::sui::SUI>(0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::slot::take_from_balance<T0>(arg5, arg6, false, arg10), arg9, arg8, arg10);
        split_and_pay_with_sui(arg2, arg3, arg4, v0, arg7, arg10);
    }

    public entry fun collect_sui(arg0: &CollectorCap, arg1: &mut Subscription, arg2: &mut 0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::fee::FeeManager, arg3: &mut 0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::bank::Bank, arg4: 0x1::ascii::String, arg5: &mut 0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::slot::Slot, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::bag::contains<address>(&arg1.subscribers, 0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::slot::get_owner(arg5)), 0);
        if (0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::slot::balance<0x2::sui::SUI>(arg5) < arg6) {
            0x2::bag::remove<address, bool>(&mut arg1.subscribers, 0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::slot::get_owner(arg5));
            return
        };
        let v0 = 0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::slot::take_from_balance<0x2::sui::SUI>(arg5, arg6, false, arg8);
        split_and_pay_with_sui(arg2, arg3, arg4, v0, arg7, arg8);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Subscription{
            id          : 0x2::object::new(arg0),
            subscribers : 0x2::bag::new(arg0),
        };
        0x2::transfer::public_share_object<Subscription>(v0);
        let v1 = CollectorCap{id: 0x2::object::new(arg0)};
        set_collector(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun set_collector(arg0: CollectorCap, arg1: address) {
        0x2::transfer::public_transfer<CollectorCap>(arg0, arg1);
        let v0 = CollectorUpdated{new_collector: arg1};
        0x2::event::emit<CollectorUpdated>(v0);
    }

    fun split_and_pay_with_sui(arg0: &mut 0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::fee::FeeManager, arg1: &mut 0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::bank::Bank, arg2: 0x1::ascii::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = (((0x2::coin::value<0x2::sui::SUI>(&arg3) as u128) * (arg4 as u128) / 100000) as u64);
        0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::bank::add_to_bank(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v0, arg5), arg5);
        0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::fee::add_fee(arg0, arg3);
        let v1 = Payment{
            payment_info : arg2,
            amount       : 0x2::coin::value<0x2::sui::SUI>(&arg3) - v0 + v0,
        };
        0x2::event::emit<Payment>(v1);
    }

    public entry fun subscribe<T0>(arg0: &mut Subscription, arg1: &mut 0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::fee::FeeManager, arg2: &mut 0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::bank::Bank, arg3: 0x1::ascii::String, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::blue_move_protocol::swap_exact_input<T0, 0x2::sui::SUI>(arg4, arg7, arg6, arg8);
        split_and_pay_with_sui(arg1, arg2, arg3, v0, arg5, arg8);
        0x2::bag::add<address, bool>(&mut arg0.subscribers, 0x2::tx_context::sender(arg8), true);
    }

    public entry fun subsribe_sui(arg0: &mut Subscription, arg1: &mut 0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::fee::FeeManager, arg2: &mut 0x9f1eec74a7c5b7f321fd1a44101374bc1d77d63797ac2e328c55d011c346d97::bank::Bank, arg3: 0x1::ascii::String, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        split_and_pay_with_sui(arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::bag::add<address, bool>(&mut arg0.subscribers, 0x2::tx_context::sender(arg6), true);
    }

    public entry fun unsubscribe(arg0: &mut Subscription, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::bag::contains<address>(&arg0.subscribers, 0x2::tx_context::sender(arg1)), 0);
        0x2::bag::remove<address, bool>(&mut arg0.subscribers, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

