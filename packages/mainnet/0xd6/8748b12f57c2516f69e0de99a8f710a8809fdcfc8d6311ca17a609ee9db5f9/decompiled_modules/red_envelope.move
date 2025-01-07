module 0xd68748b12f57c2516f69e0de99a8f710a8809fdcfc8d6311ca17a609ee9db5f9::red_envelope {
    struct RedEnvelopeTreasury<phantom T0> has key {
        id: 0x2::object::UID,
        treasury: 0x2::balance::Balance<T0>,
        msg_author_pubkey: 0x1::option::Option<vector<u8>>,
        claim_record: 0x2::table::Table<address, u64>,
        claim_enabled: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ClaimRedEnvelopeEvent has copy, drop {
        sender: address,
        amount: u64,
    }

    struct AddTreasuryEvent has copy, drop {
        sender: address,
        amount: u64,
    }

    struct WithdrawTreasuryEvent has copy, drop {
        sender: address,
        amount: u64,
    }

    struct SetAuthorEvent has copy, drop {
        sender: address,
        old_author: vector<u8>,
        new_author: vector<u8>,
    }

    public fun add_treasury<T0>(arg0: &mut RedEnvelopeTreasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = AddTreasuryEvent{
            sender : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<AddTreasuryEvent>(v0);
        0x2::balance::join<T0>(&mut arg0.treasury, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun claim<T0>(arg0: &mut RedEnvelopeTreasury<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.claim_enabled, 5);
        assert!(0x1::option::is_some<vector<u8>>(&arg0.msg_author_pubkey), 2);
        assert!(0x2::ed25519::ed25519_verify(&arg1, 0x1::option::borrow<vector<u8>>(&arg0.msg_author_pubkey), &arg2), 1);
        let v0 = 0x2::bcs::new(arg2);
        let v1 = 0x2::bcs::peel_u64(&mut v0);
        assert!(0x2::bcs::peel_vec_u8(&mut v0) == b"red_envelope", 6);
        let v2 = 0x2::tx_context::sender(arg3);
        assert!(0x2::bcs::peel_address(&mut v0) == v2, 3);
        assert!(0x2::table::contains<address, u64>(&arg0.claim_record, v2) == false, 4);
        0x2::table::add<address, u64>(&mut arg0.claim_record, v2, v1);
        let v3 = ClaimRedEnvelopeEvent{
            sender : v2,
            amount : v1,
        };
        0x2::event::emit<ClaimRedEnvelopeEvent>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.treasury, v1), arg3)
    }

    public entry fun create_red_envelope_treasury<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RedEnvelopeTreasury<T0>{
            id                : 0x2::object::new(arg1),
            treasury          : 0x2::balance::zero<T0>(),
            msg_author_pubkey : 0x1::option::none<vector<u8>>(),
            claim_record      : 0x2::table::new<address, u64>(arg1),
            claim_enabled     : true,
        };
        0x2::transfer::share_object<RedEnvelopeTreasury<T0>>(v0);
    }

    public fun disable_claim<T0>(arg0: &AdminCap, arg1: &mut RedEnvelopeTreasury<T0>) {
        arg1.claim_enabled = false;
    }

    public fun enable_claim<T0>(arg0: &AdminCap, arg1: &mut RedEnvelopeTreasury<T0>) {
        arg1.claim_enabled = true;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun set_msg_author<T0>(arg0: &AdminCap, arg1: &mut RedEnvelopeTreasury<T0>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = SetAuthorEvent{
            sender     : 0x2::tx_context::sender(arg3),
            old_author : 0x1::option::get_with_default<vector<u8>>(&arg1.msg_author_pubkey, 0x1::vector::empty<u8>()),
            new_author : arg2,
        };
        0x2::event::emit<SetAuthorEvent>(v0);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg1.msg_author_pubkey, arg2);
    }

    public fun withdraw_treasury<T0>(arg0: &AdminCap, arg1: &mut RedEnvelopeTreasury<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = WithdrawTreasuryEvent{
            sender : 0x2::tx_context::sender(arg3),
            amount : arg2,
        };
        0x2::event::emit<WithdrawTreasuryEvent>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.treasury, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

