module 0xfc0c61c3a24d440f25d9f0d7accd4b61769f85d76e196dc1f3cf60daf6a50cd8::bank {
    struct Bank has store, key {
        id: 0x2::object::UID,
        deposit_count: u64,
        owner: address,
    }

    struct NFTDeposit has store {
        owner: address,
        amount: u64,
    }

    struct InfoKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct NFTDeposited has copy, drop {
        bank_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct NFTWithdrawn has copy, drop {
        bank_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    public fun bank_exists(arg0: &Bank, arg1: address) : bool {
        arg0.owner == arg1
    }

    public fun contains_nft(arg0: &Bank, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1)
    }

    public entry fun create_and_share_bank(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Bank>(create_bank(arg0));
    }

    public fun create_bank(arg0: &mut 0x2::tx_context::TxContext) : Bank {
        Bank{
            id            : 0x2::object::new(arg0),
            deposit_count : 0,
            owner         : 0x2::tx_context::sender(arg0),
        }
    }

    fun create_info_key(arg0: 0x2::object::ID) : InfoKey {
        InfoKey{id: arg0}
    }

    public fun deposit<T0: store + key>(arg0: &mut Bank, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id<T0>(&arg1);
        arg0.deposit_count = arg0.deposit_count + 1;
        let v2 = NFTDeposit{
            owner  : v0,
            amount : arg2,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v1, arg1);
        0x2::dynamic_field::add<InfoKey, NFTDeposit>(&mut arg0.id, create_info_key(v1), v2);
        let v3 = NFTDeposited{
            bank_id : 0x2::object::id<Bank>(arg0),
            nft_id  : v1,
            owner   : v0,
            amount  : arg2,
        };
        0x2::event::emit<NFTDeposited>(v3);
    }

    public fun deposit_count(arg0: &Bank) : u64 {
        arg0.deposit_count
    }

    public fun get_nft_owner(arg0: &Bank, arg1: 0x2::object::ID) : address {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 2);
        0x2::dynamic_field::borrow<InfoKey, NFTDeposit>(&arg0.id, create_info_key(arg1)).owner
    }

    public fun is_owner(arg0: &Bank, arg1: address) : bool {
        arg0.owner == arg1
    }

    public fun withdraw<T0: store + key>(arg0: &mut Bank, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 2);
        let NFTDeposit {
            owner  : v1,
            amount : v2,
        } = 0x2::dynamic_field::remove<InfoKey, NFTDeposit>(&mut arg0.id, create_info_key(arg1));
        assert!(v1 == v0, 0);
        arg0.deposit_count = arg0.deposit_count - 1;
        let v3 = NFTWithdrawn{
            bank_id : 0x2::object::id<Bank>(arg0),
            nft_id  : arg1,
            owner   : v0,
            amount  : v2,
        };
        0x2::event::emit<NFTWithdrawn>(v3);
        0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1)
    }

    // decompiled from Move bytecode v6
}

