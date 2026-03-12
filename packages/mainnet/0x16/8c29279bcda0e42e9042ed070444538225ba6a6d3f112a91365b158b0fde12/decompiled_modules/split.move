module 0x168c29279bcda0e42e9042ed070444538225ba6a6d3f112a91365b158b0fde12::split {
    struct Recipient has copy, drop, store {
        wallet: address,
        share_bps: u64,
        claimed: u64,
    }

    struct Split has key {
        id: 0x2::object::UID,
        creator: address,
        name: vector<u8>,
        recipients: vector<Recipient>,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        total_received: u64,
        created_at: u64,
    }

    struct SplitCreated has copy, drop {
        split_id: address,
        creator: address,
        name: vector<u8>,
    }

    entry fun claim(arg0: &mut Split, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.vault);
        let v2 = 0;
        let v3 = false;
        while (v2 < 0x1::vector::length<Recipient>(&arg0.recipients)) {
            let v4 = 0x1::vector::borrow_mut<Recipient>(&mut arg0.recipients, v2);
            if (v4.wallet == v0) {
                v3 = true;
                let v5 = arg0.total_received * v4.share_bps / 10000;
                let v6 = if (v5 > v4.claimed) {
                    v5 - v4.claimed
                } else {
                    0
                };
                assert!(v6 > 0, 6);
                let v7 = if (v6 > v1) {
                    v1
                } else {
                    v6
                };
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v7), arg1), v0);
                v4.claimed = v4.claimed + v7;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v3, 5);
    }

    entry fun close_split(arg0: Split, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 7);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.vault) == 0, 9);
        let Split {
            id             : v0,
            creator        : _,
            name           : _,
            recipients     : _,
            vault          : v4,
            total_received : _,
            created_at     : _,
        } = arg0;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v4);
        0x2::object::delete(v0);
    }

    entry fun create_split(arg0: vector<u8>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(0x1::vector::length<u8>(&arg0) > 0, 8);
        assert!(v0 > 0, 2);
        assert!(v0 <= 10, 1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 2);
        let v1 = 0x1::vector::empty<Recipient>();
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<u64>(&arg2, v3);
            assert!(v4 > 0 && v4 <= 10000, 3);
            let v5 = *0x1::vector::borrow<address>(&arg1, v3);
            let v6 = 0;
            while (v6 < v3) {
                assert!(0x1::vector::borrow<Recipient>(&v1, v6).wallet != v5, 4);
                v6 = v6 + 1;
            };
            let v7 = Recipient{
                wallet    : v5,
                share_bps : v4,
                claimed   : 0,
            };
            0x1::vector::push_back<Recipient>(&mut v1, v7);
            v2 = v2 + v4;
            v3 = v3 + 1;
        };
        assert!(v2 == 10000, 0);
        let v8 = 0x2::tx_context::sender(arg3);
        let v9 = Split{
            id             : 0x2::object::new(arg3),
            creator        : v8,
            name           : arg0,
            recipients     : v1,
            vault          : 0x2::balance::zero<0x2::sui::SUI>(),
            total_received : 0,
            created_at     : 0x2::tx_context::epoch(arg3),
        };
        let v10 = SplitCreated{
            split_id : 0x2::object::uid_to_address(&v9.id),
            creator  : v8,
            name     : v9.name,
        };
        0x2::event::emit<SplitCreated>(v10);
        0x2::transfer::share_object<Split>(v9);
    }

    entry fun deposit(arg0: &mut Split, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        arg0.total_received = arg0.total_received + 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    entry fun distribute(arg0: &mut Split, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.vault);
        assert!(v0 > 0, 6);
        let v1 = 0x1::vector::length<Recipient>(&arg0.recipients);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            let v4 = 0x1::vector::borrow_mut<Recipient>(&mut arg0.recipients, v3);
            let v5 = if (v3 == v1 - 1) {
                v0 - v2
            } else {
                v0 * v4.share_bps / 10000
            };
            if (v5 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v5), arg1), v4.wallet);
                v4.claimed = v4.claimed + v5;
                v2 = v2 + v5;
            };
            v3 = v3 + 1;
        };
    }

    public fun get_creator(arg0: &Split) : address {
        arg0.creator
    }

    public fun get_name(arg0: &Split) : vector<u8> {
        arg0.name
    }

    public fun get_recipient_count(arg0: &Split) : u64 {
        0x1::vector::length<Recipient>(&arg0.recipients)
    }

    public fun get_total_received(arg0: &Split) : u64 {
        arg0.total_received
    }

    public fun get_vault_balance(arg0: &Split) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.vault)
    }

    // decompiled from Move bytecode v6
}

