module 0x28272b9480d64424f429251d84e17ce97894da564c042f628570da95397d3568::bank {
    struct BankSignerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Bank has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        coupons: 0x2::bag::Bag,
        signer_public_key: vector<u8>,
    }

    struct Claimed has copy, drop, store {
        coupon_hash: vector<u8>,
        receiver: address,
        amount: u64,
    }

    struct SignerUpdated has copy, drop, store {
        new_signer: address,
    }

    struct UserFeeAmount has copy, drop, store {
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
        let v1 = UserFeeAmount{amount: 0x2::coin::value<0x2::sui::SUI>(&arg1)};
        0x2::event::emit<UserFeeAmount>(v1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun cancel_coupon(arg0: &BankSignerCap, arg1: &mut Bank, arg2: vector<u8>) {
        0x2::bag::add<vector<u8>, bool>(&mut arg1.coupons, arg2, true);
        let v0 = Cancelled{coupon_hash: arg2};
        0x2::event::emit<Cancelled>(v0);
    }

    public entry fun claim_coupon(arg0: &mut Bank, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg6) < arg5, 3);
        assert!(!0x2::bag::contains<vector<u8>>(&arg0.coupons, arg2), 4);
        0x2::bag::add<vector<u8>, bool>(&mut arg0.coupons, arg2, true);
        0x1::vector::append<u8>(&mut arg2, 0x2::bcs::to_bytes<address>(&arg3));
        0x1::vector::append<u8>(&mut arg2, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut arg2, 0x2::bcs::to_bytes<u64>(&arg5));
        let v0 = 0x2::hash::keccak256(&arg2);
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg0.signer_public_key, &v0), 1);
        withdraw_and_transfer(arg0, arg3, arg4, arg7);
        let v1 = Claimed{
            coupon_hash : arg2,
            receiver    : arg3,
            amount      : arg4,
        };
        0x2::event::emit<Claimed>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id                : 0x2::object::new(arg0),
            balance           : 0x2::balance::zero<0x2::sui::SUI>(),
            coupons           : 0x2::bag::new(arg0),
            signer_public_key : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::public_share_object<Bank>(v0);
        let v1 = BankSignerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<BankSignerCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = SignerUpdated{new_signer: 0x2::tx_context::sender(arg0)};
        0x2::event::emit<SignerUpdated>(v2);
    }

    public entry fun set_signer(arg0: &mut Bank, arg1: BankSignerCap, arg2: address, arg3: vector<u8>) {
        assert!(arg2 != @0x0, 0);
        arg0.signer_public_key = arg3;
        0x2::transfer::public_transfer<BankSignerCap>(arg1, arg2);
        let v0 = SignerUpdated{new_signer: arg2};
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

