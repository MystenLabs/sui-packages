module 0xf30d962db5abcc45bebcdf8e36f8940083d62266a47bf491b2453468c3fc0e73::bank {
    struct BankSignerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Bank has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        coupons: 0x2::bag::Bag,
    }

    struct Claimed has copy, drop, store {
        coupon_hash: vector<u8>,
        receiver: address,
        amount: u64,
    }

    struct SignerUpdated has copy, drop, store {
        new_signer: address,
    }

    struct UserFeePayed has copy, drop, store {
        amount: u64,
    }

    struct Cancelled has copy, drop, store {
        coupon_hash: vector<u8>,
    }

    struct Withdrawn has copy, drop, store {
        user: address,
        amount: u64,
    }

    struct Received has copy, drop, store {
        sender: address,
        value: u64,
    }

    public entry fun add_to_bank(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        let v0 = Received{
            sender : 0x2::tx_context::sender(arg2),
            value  : 0x2::coin::value<0x2::sui::SUI>(&arg1),
        };
        0x2::event::emit<Received>(v0);
        let v1 = UserFeePayed{amount: 0x2::coin::value<0x2::sui::SUI>(&arg1)};
        0x2::event::emit<UserFeePayed>(v1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun cancel_coupon(arg0: &BankSignerCap, arg1: &mut Bank, arg2: vector<u8>) {
        0x2::bag::add<vector<u8>, bool>(&mut arg1.coupons, arg2, true);
        let v0 = Cancelled{coupon_hash: arg2};
        0x2::event::emit<Cancelled>(v0);
    }

    public entry fun claim_coupon(arg0: &mut Bank, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg7) < arg6, 3);
        assert!(!0x2::bag::contains<vector<u8>>(&arg0.coupons, arg3), 4);
        0x2::bag::add<vector<u8>, bool>(&mut arg0.coupons, arg3, true);
        0x1::vector::append<u8>(&mut arg3, 0x2::bcs::to_bytes<address>(&arg4));
        0x1::vector::append<u8>(&mut arg3, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut arg3, 0x2::bcs::to_bytes<u64>(&arg6));
        let v0 = 0x2::hash::keccak256(&arg3);
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg1, &v0), 1);
        withdraw_and_transfer(arg0, arg4, arg5, arg8);
        let v1 = Claimed{
            coupon_hash : arg3,
            receiver    : arg4,
            amount      : arg5,
        };
        0x2::event::emit<Claimed>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            coupons : 0x2::bag::new(arg0),
        };
        0x2::transfer::public_share_object<Bank>(v0);
        let v1 = BankSignerCap{id: 0x2::object::new(arg0)};
        set_signer(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun set_signer(arg0: BankSignerCap, arg1: address) {
        assert!(arg1 != @0x0, 0);
        0x2::transfer::public_transfer<BankSignerCap>(arg0, arg1);
        let v0 = SignerUpdated{new_signer: arg1};
        0x2::event::emit<SignerUpdated>(v0);
    }

    fun withdraw_and_transfer(arg0: &mut Bank, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v0 >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg3), arg1);
    }

    public entry fun withdraw_sui(arg0: &BankSignerCap, arg1: &mut Bank, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        withdraw_and_transfer(arg1, arg2, arg3, arg4);
        let v0 = Withdrawn{
            user   : arg2,
            amount : arg3,
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

