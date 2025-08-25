module 0x127882a2e36d49c03b40bf88f1ab7faf22d1b2c88b1275b86057d52001fc9561::sui_token_bridge {
    struct Bridge has key {
        id: 0x2::object::UID,
        admin: address,
        relayers: 0x2::table::Table<address, bool>,
        vault: 0x2::balance::Balance<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>,
        nonce: u64,
    }

    struct DepositReceipt has key {
        id: 0x2::object::UID,
        depositor: address,
        receiver_eth: vector<u8>,
        amount: u64,
        dest_chain_id: u16,
        nonce: u64,
    }

    struct ReleaseVoucher has key {
        id: 0x2::object::UID,
        recipient: address,
        balance: 0x2::balance::Balance<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>,
        external_tx_hash: vector<u8>,
        issued_by: address,
        nonce: u64,
    }

    struct DepositEvent has copy, drop {
        user: address,
        amount: u64,
        dest_chain_id: u16,
        receiver_eth: vector<u8>,
        nonce: u64,
        receipt_id: 0x2::object::ID,
    }

    struct ReleaseCreatedEvent has copy, drop {
        recipient: address,
        amount: u64,
        nonce: u64,
        voucher_id: 0x2::object::ID,
        external_tx_hash: vector<u8>,
        issued_by: address,
    }

    struct ClaimedEvent has copy, drop {
        user: address,
        amount: u64,
        voucher_id: 0x2::object::ID,
        external_tx_hash: vector<u8>,
    }

    struct SUI_TOKEN_BRIDGE has drop {
        dummy_field: bool,
    }

    public entry fun add_relayer(arg0: &mut Bridge, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        if (!0x2::table::contains<address, bool>(&arg0.relayers, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.relayers, arg1, true);
        };
    }

    public entry fun admin_deposit_liquidity(arg0: &mut Bridge, arg1: 0x2::coin::Coin<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        assert!(0x2::coin::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&arg1) > 0, 3);
        0x2::balance::join<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&mut arg0.vault, 0x2::coin::into_balance<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(arg1));
    }

    public fun admin_of(arg0: &Bridge) : address {
        arg0.admin
    }

    public fun admin_withdraw_liquidity(arg0: &mut Bridge, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C> {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        assert!(arg1 > 0, 3);
        assert!(0x2::balance::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&arg0.vault) >= arg1, 4);
        0x2::coin::from_balance<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(0x2::balance::split<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&mut arg0.vault, arg1), arg2)
    }

    public fun claim(arg0: ReleaseVoucher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C> {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.recipient == v0, 5);
        let ReleaseVoucher {
            id               : v1,
            recipient        : _,
            balance          : v3,
            external_tx_hash : v4,
            issued_by        : _,
            nonce            : _,
        } = arg0;
        let v7 = v3;
        let v8 = v1;
        let v9 = ClaimedEvent{
            user             : v0,
            amount           : 0x2::balance::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&v7),
            voucher_id       : 0x2::object::uid_to_inner(&v8),
            external_tx_hash : v4,
        };
        0x2::event::emit<ClaimedEvent>(v9);
        0x2::object::delete(v8);
        0x2::coin::from_balance<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(v7, arg1)
    }

    public entry fun create_release_voucher(arg0: &mut Bridge, arg1: address, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::table::contains<address, bool>(&arg0.relayers, v0) && *0x2::table::borrow<address, bool>(&arg0.relayers, v0);
        assert!(v0 == arg0.admin || v1, 2);
        assert!(arg2 > 0, 3);
        assert!(0x2::balance::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&arg0.vault) >= arg2, 4);
        let v2 = arg0.nonce;
        arg0.nonce = v2 + 1;
        let v3 = ReleaseVoucher{
            id               : 0x2::object::new(arg4),
            recipient        : arg1,
            balance          : 0x2::balance::split<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&mut arg0.vault, arg2),
            external_tx_hash : arg3,
            issued_by        : v0,
            nonce            : v2,
        };
        let v4 = ReleaseCreatedEvent{
            recipient        : arg1,
            amount           : arg2,
            nonce            : v2,
            voucher_id       : 0x2::object::id<ReleaseVoucher>(&v3),
            external_tx_hash : v3.external_tx_hash,
            issued_by        : v0,
        };
        0x2::event::emit<ReleaseCreatedEvent>(v4);
        0x2::transfer::transfer<ReleaseVoucher>(v3, arg1);
    }

    public fun deposit_receipt_info(arg0: &DepositReceipt) : (address, vector<u8>, u64, u16, u64) {
        (arg0.depositor, arg0.receiver_eth, arg0.amount, arg0.dest_chain_id, arg0.nonce)
    }

    fun init(arg0: SUI_TOKEN_BRIDGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Bridge{
            id       : 0x2::object::new(arg1),
            admin    : 0x2::tx_context::sender(arg1),
            relayers : 0x2::table::new<address, bool>(arg1),
            vault    : 0x2::balance::zero<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(),
            nonce    : 1,
        };
        0x2::transfer::share_object<Bridge>(v0);
    }

    public fun is_relayer(arg0: &Bridge, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.relayers, arg1) && *0x2::table::borrow<address, bool>(&arg0.relayers, arg1)
    }

    public fun release_voucher_info(arg0: &ReleaseVoucher) : (address, u64, vector<u8>, address, u64) {
        (arg0.recipient, 0x2::balance::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&arg0.balance), arg0.external_tx_hash, arg0.issued_by, arg0.nonce)
    }

    public entry fun remove_relayer(arg0: &mut Bridge, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        if (0x2::table::contains<address, bool>(&arg0.relayers, arg1)) {
            0x2::table::remove<address, bool>(&mut arg0.relayers, arg1);
        };
    }

    public entry fun user_deposit(arg0: &mut Bridge, arg1: u16, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&arg3);
        assert!(v1 > 0, 3);
        0x2::balance::join<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&mut arg0.vault, 0x2::coin::into_balance<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(arg3));
        let v2 = arg0.nonce;
        arg0.nonce = v2 + 1;
        let v3 = DepositReceipt{
            id            : 0x2::object::new(arg4),
            depositor     : v0,
            receiver_eth  : arg2,
            amount        : v1,
            dest_chain_id : arg1,
            nonce         : v2,
        };
        let v4 = DepositEvent{
            user          : v0,
            amount        : v1,
            dest_chain_id : arg1,
            receiver_eth  : arg2,
            nonce         : v2,
            receipt_id    : 0x2::object::id<DepositReceipt>(&v3),
        };
        0x2::event::emit<DepositEvent>(v4);
        0x2::transfer::transfer<DepositReceipt>(v3, v0);
    }

    public fun vault_amount(arg0: &Bridge) : u64 {
        0x2::balance::value<0x84b27ddadc6139c7e8837fef6759eba4670ba3fc0679acd118b4e9252f834e29::e4c::E4C>(&arg0.vault)
    }

    // decompiled from Move bytecode v6
}

