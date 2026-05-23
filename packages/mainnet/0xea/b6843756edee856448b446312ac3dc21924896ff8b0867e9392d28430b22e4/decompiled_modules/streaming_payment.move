module 0xeab6843756edee856448b446312ac3dc21924896ff8b0867e9392d28430b22e4::streaming_payment {
    struct Payment<phantom T0> has store {
        from: address,
        to: address,
        start: u64,
        end: u64,
        origin_value: u64,
        total: 0x2::balance::Balance<T0>,
    }

    struct Payments<phantom T0> has key {
        id: 0x2::object::UID,
        records: 0x2::table::Table<address, vector<Payment<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>>,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        coin_types: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    fun calc(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg3 >= arg2) {
            arg0
        } else {
            (((arg0 as u256) * ((arg3 - arg1) as u256) / ((arg2 - arg1) as u256)) as u64)
        }
    }

    public fun create_payment<T0>(arg0: &mut Payments<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 0, 0);
        if (!0x2::table::contains<address, vector<Payment<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>>(&arg0.records, arg6)) {
            0x2::table::add<address, vector<Payment<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>>(&mut arg0.records, arg6, 0x1::vector::empty<Payment<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>());
        };
        0x1::vector::push_back<Payment<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(0x2::table::borrow_mut<address, vector<Payment<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>>(&mut arg0.records, arg6), new_payment<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg1, arg2, arg3, arg4, arg7)), arg5, arg6, 0x2::coin::value<T0>(&arg3), arg7));
    }

    public fun create_payments<T0>(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Payments<T0>{
            id      : 0x2::object::new(arg1),
            records : 0x2::table::new<address, vector<Payment<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>>(arg1),
        };
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.coin_types, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())), 0x2::object::uid_to_inner(&v0.id));
        0x2::transfer::share_object<Payments<T0>>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id         : 0x2::object::new(arg0),
            coin_types : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    fun new_payment<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: address, arg3: u64, arg4: &0x2::tx_context::TxContext) : Payment<T0> {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg4) + 86400000;
        Payment<T0>{
            from         : 0x2::tx_context::sender(arg4),
            to           : arg2,
            start        : v0,
            end          : v0 + arg1 * 86400000,
            origin_value : arg3,
            total        : arg0,
        }
    }

    public fun withdraw<T0>(arg0: &mut Payments<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg4);
        let v1 = 0x2::table::borrow_mut<address, vector<Payment<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>>(&mut arg0.records, 0x2::tx_context::sender(arg4));
        let v2 = 0;
        while (v2 < 0x1::vector::length<Payment<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v1)) {
            let v3 = 0x1::vector::borrow_mut<Payment<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v1, v2);
            let v4 = 0x2::clock::timestamp_ms(arg3);
            if (v4 <= v3.start) {
            } else {
                let v5 = calc(v3.origin_value, v3.start, v3.end, v4);
                v3.start = v4;
                v3.origin_value = v3.origin_value - v5;
                let v6 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg1, arg2, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut v3.total, calc(0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v3.total), v3.start, v3.end, v4)), arg4), arg3, arg4);
                if (0x2::coin::value<T0>(&v6) <= v5) {
                    0x2::coin::join<T0>(&mut v0, v6);
                } else {
                    0x2::coin::join<T0>(&mut v0, 0x2::coin::split<T0>(&mut v6, v5, arg4));
                    let v7 = 0x2::coin::value<T0>(&v6);
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v6, v7 / 1000, arg4), @0x9e4092b6a894e6b168aa1c6c009f5c1c1fcb83fb95e5aa39144e1d2be4ee0d67);
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v6, (v7 - v7 / 1000) / 2, arg4), v3.from);
                    0x2::coin::join<T0>(&mut v0, v6);
                };
            };
            v2 = v2 + 1;
        };
        let v8 = vector[];
        let v9 = 0;
        while (v9 < 0x1::vector::length<Payment<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v1)) {
            let v10 = 0x1::vector::borrow<Payment<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v1, v9);
            if (v10.start >= v10.end) {
                0x1::vector::push_back<u64>(&mut v8, v9);
            };
            v9 = v9 + 1;
        };
        let v11 = 0;
        while (v11 < 0x1::vector::length<u64>(&v8)) {
            let Payment {
                from         : _,
                to           : _,
                start        : _,
                end          : _,
                origin_value : _,
                total        : v17,
            } = 0x1::vector::swap_remove<Payment<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(v1, 0x1::vector::pop_back<u64>(&mut v8));
            0x2::balance::destroy_zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v17);
            v11 = v11 + 1;
        };
        0x1::vector::destroy_empty<u64>(v8);
        v0
    }

    // decompiled from Move bytecode v7
}

