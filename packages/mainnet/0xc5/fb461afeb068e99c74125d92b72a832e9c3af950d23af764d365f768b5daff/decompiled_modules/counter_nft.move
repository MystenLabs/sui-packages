module 0xc5fb461afeb068e99c74125d92b72a832e9c3af950d23af764d365f768b5daff::counter_nft {
    struct Counter has key {
        id: 0x2::object::UID,
        count: u64,
    }

    entry fun burn(arg0: Counter) {
        let Counter {
            id    : v0,
            count : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun count(arg0: &Counter) : u64 {
        arg0.count
    }

    public fun get_vrf_input_and_increment(arg0: &mut Counter) : vector<u8> {
        let v0 = 0x2::object::id_bytes<Counter>(arg0);
        let v1 = count(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v1));
        increment(arg0);
        v0
    }

    fun increment(arg0: &mut Counter) {
        arg0.count = arg0.count + 1;
    }

    public fun mint<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xc5fb461afeb068e99c74125d92b72a832e9c3af950d23af764d365f768b5daff::pool_data::GamePool<T0>, arg2: &0xc5fb461afeb068e99c74125d92b72a832e9c3af950d23af764d365f768b5daff::pool_data::NFTPrice, arg3: &mut 0x2::tx_context::TxContext) : Counter {
        let v0 = 0x1::type_name::get<T0>();
        assert!(&v0 == 0xc5fb461afeb068e99c74125d92b72a832e9c3af950d23af764d365f768b5daff::pool_data::borrow_nft_coin_type(arg2), 0);
        assert!(0x2::coin::value<T0>(&arg0) == 0xc5fb461afeb068e99c74125d92b72a832e9c3af950d23af764d365f768b5daff::pool_data::get_nft_price(arg2), 1);
        0x2::balance::join<T0>(0xc5fb461afeb068e99c74125d92b72a832e9c3af950d23af764d365f768b5daff::pool_data::borrow_balance_mut<T0>(arg1), 0x2::coin::into_balance<T0>(arg0));
        Counter{
            id    : 0x2::object::new(arg3),
            count : 0,
        }
    }

    public fun transfer_to_sender(arg0: Counter, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Counter>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

