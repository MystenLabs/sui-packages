module 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist {
    struct Whitelist has store {
        pos0: 0x2::table::Table<address, 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::wallet_state::WalletState>,
    }

    struct AddToWhitelist has copy, drop {
        wallets: vector<address>,
    }

    struct RemoveFromWhitelist has copy, drop {
        wallets: vector<address>,
    }

    public(friend) fun add(arg0: &mut Whitelist, arg1: vector<address>, arg2: u64) {
        0x1::vector::reverse<address>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            assert!(!contains(arg0, v1), 0);
            0x2::table::add<address, 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::wallet_state::WalletState>(&mut arg0.pos0, v1, 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::wallet_state::new(0, arg2, 0));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg1);
        let v2 = AddToWhitelist{wallets: arg1};
        0x2::event::emit<AddToWhitelist>(v2);
    }

    public(friend) fun contains(arg0: &Whitelist, arg1: address) : bool {
        0x2::table::contains<address, 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::wallet_state::WalletState>(&arg0.pos0, arg1)
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Whitelist {
        Whitelist{pos0: 0x2::table::new<address, 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::wallet_state::WalletState>(arg0)}
    }

    public(friend) fun remove(arg0: &mut Whitelist, arg1: vector<address>) {
        0x1::vector::reverse<address>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            assert!(contains(arg0, v1), 1);
            0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::wallet_state::destroy(0x2::table::remove<address, 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::wallet_state::WalletState>(&mut arg0.pos0, v1));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg1);
        let v2 = RemoveFromWhitelist{wallets: arg1};
        0x2::event::emit<RemoveFromWhitelist>(v2);
    }

    public(friend) fun wallet_state(arg0: &Whitelist, arg1: address) : &0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::wallet_state::WalletState {
        0x2::table::borrow<address, 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::wallet_state::WalletState>(&arg0.pos0, arg1)
    }

    public(friend) fun wallet_state_mut(arg0: &mut Whitelist, arg1: address) : &mut 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::wallet_state::WalletState {
        0x2::table::borrow_mut<address, 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::wallet_state::WalletState>(&mut arg0.pos0, arg1)
    }

    // decompiled from Move bytecode v6
}

