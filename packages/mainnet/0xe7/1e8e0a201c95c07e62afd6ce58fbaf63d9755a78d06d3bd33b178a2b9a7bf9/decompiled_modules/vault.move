module 0xe71e8e0a201c95c07e62afd6ce58fbaf63d9755a78d06d3bd33b178a2b9a7bf9::vault {
    struct WithdrawEvent has copy, drop {
        user: address,
        amount: u64,
        nonce: u64,
        token: vector<u8>,
    }

    struct DepositEvent has copy, drop {
        user: address,
        amount: u64,
        token: vector<u8>,
    }

    struct NonceEvent has copy, drop {
        id: 0x2::object::ID,
        user: address,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct UserNonce has key {
        id: 0x2::object::UID,
        nonce: u64,
    }

    struct Storage<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        signer: vector<u8>,
        package: address,
        token: vector<u8>,
    }

    public entry fun createNonce(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserNonce{
            id    : 0x2::object::new(arg0),
            nonce : 0,
        };
        let v1 = NonceEvent{
            id   : 0x2::object::id<UserNonce>(&v0),
            user : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<NonceEvent>(v1);
        0x2::transfer::transfer<UserNonce>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun createStorage<T0>(arg0: address, arg1: vector<u8>, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Storage<T0>{
            id      : 0x2::object::new(arg3),
            balance : 0x2::balance::zero<T0>(),
            signer  : arg1,
            package : arg0,
            token   : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::transfer::share_object<Storage<T0>>(v0);
    }

    public entry fun deposit<T0>(arg0: u64, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut Storage<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 0x2::clock::timestamp_ms(arg5), 9223372766999216129);
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(v0 == arg4.token, 9223372775589543943);
        assert!(verifyDepositSignature(arg4.package, 0x2::tx_context::sender(arg6), v0, arg0, arg1, arg4.signer, arg2), 9223372779884380165);
        0x2::balance::join<T0>(&mut arg4.balance, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg3), arg0));
        let v1 = DepositEvent{
            user   : 0x2::tx_context::sender(arg6),
            amount : arg0,
            token  : v0,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun depositFund<T0>(arg0: u64, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut Storage<T0>, arg3: &AdminCap) {
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg1), arg0));
    }

    public fun emergencyWithdraw<T0>(arg0: u64, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut Storage<T0>, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T0>(arg1, 0x2::coin::take<T0>(&mut arg2.balance, arg0, arg4));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun setPackage<T0>(arg0: &mut Storage<T0>, arg1: address, arg2: &AdminCap) {
        arg0.package = arg1;
    }

    public fun setSigner<T0>(arg0: &mut Storage<T0>, arg1: vector<u8>, arg2: &AdminCap) {
        arg0.signer = arg1;
    }

    public fun verifyDepositSignature(arg0: address, arg1: address, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>) : bool {
        let v0 = 0x1::string::utf8(b"deposit");
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::string::utf8(0x2::hex::encode(0x2::address::to_bytes(arg0))));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::string::utf8(0x2::hex::encode(0x2::address::to_bytes(arg1))));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::string::utf8(arg2));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg3));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg4));
        0x2::ed25519::ed25519_verify(&arg6, &arg5, 0x1::string::as_bytes(&v0))
    }

    public fun verifyWithdrawSignature(arg0: address, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: vector<u8>) : bool {
        let v0 = 0x1::string::utf8(b"withdraw");
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::string::utf8(0x2::hex::encode(0x2::address::to_bytes(arg0))));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::string::utf8(0x2::hex::encode(0x2::address::to_bytes(arg1))));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::string::utf8(arg2));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::string::utf8(arg3));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg4));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg5));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg6));
        0x2::ed25519::ed25519_verify(&arg8, &arg7, 0x1::string::as_bytes(&v0))
    }

    public entry fun withdraw<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &mut Storage<T0>, arg5: &mut UserNonce, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg6), 9223372638150197249);
        assert!(arg1 == arg5.nonce, 9223372642445295619);
        let v0 = 0x2::object::id<UserNonce>(arg5);
        let v1 = 0x2::object::id<Storage<T0>>(arg4);
        assert!(verifyWithdrawSignature(arg4.package, 0x2::tx_context::sender(arg7), 0x2::hex::encode(0x2::object::id_to_bytes(&v1)), 0x2::hex::encode(0x2::object::id_to_bytes(&v0)), arg0, arg1, arg2, arg4.signer, arg3), 9223372659625295877);
        arg5.nonce = arg5.nonce + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg4.balance, arg0, arg7), 0x2::tx_context::sender(arg7));
        let v2 = WithdrawEvent{
            user   : 0x2::tx_context::sender(arg7),
            amount : arg0,
            nonce  : arg5.nonce - 1,
            token  : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::event::emit<WithdrawEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

