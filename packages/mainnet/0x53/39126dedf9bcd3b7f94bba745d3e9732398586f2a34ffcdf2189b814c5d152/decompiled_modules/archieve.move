module 0x5339126dedf9bcd3b7f94bba745d3e9732398586f2a34ffcdf2189b814c5d152::archieve {
    struct ARCHIEVE has drop {
        dummy_field: bool,
    }

    struct UserArchieve has store, key {
        id: 0x2::object::UID,
        peg_token_nonce: u128,
        depeg_token_nonce: u128,
        peg_nft_nonce: u128,
        depeg_nft_nonce: u128,
        peg_prey_nonce: u128,
        depeg_prey_nonce: u128,
        total_deposit: u64,
        total_withdraw: u64,
    }

    struct UserReg has store, key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, bool>,
    }

    public fun decreaseToTalDeposit(arg0: u64, arg1: &mut UserArchieve) : u64 {
        assert!(arg1.total_deposit >= arg0, 8004);
        arg1.total_deposit = arg1.total_deposit - arg0;
        arg1.total_deposit
    }

    public fun decreaseToTalWithdraw(arg0: u64, arg1: &mut UserArchieve) : u64 {
        assert!(arg1.total_withdraw >= arg0, 8004);
        arg1.total_withdraw = arg1.total_withdraw - arg0;
        arg1.total_withdraw
    }

    public fun increaseGetNftDepegNonce(arg0: &mut UserArchieve) : u128 {
        arg0.depeg_nft_nonce = arg0.depeg_nft_nonce + 1;
        arg0.depeg_nft_nonce
    }

    public fun increaseGetPreyDepegNonce(arg0: &mut UserArchieve) : u128 {
        arg0.depeg_prey_nonce = arg0.depeg_prey_nonce + 1;
        arg0.depeg_prey_nonce
    }

    public fun increaseGetTokenDepegNonce(arg0: &mut UserArchieve) : u128 {
        arg0.depeg_token_nonce = arg0.depeg_token_nonce + 1;
        arg0.depeg_token_nonce
    }

    public fun increaseTotalDeposit(arg0: u64, arg1: &mut UserArchieve) : u64 {
        arg1.total_deposit = arg1.total_deposit + arg0;
        arg1.total_deposit
    }

    public fun increaseTotalWithdraw(arg0: u64, arg1: &mut UserArchieve) : u64 {
        arg1.total_withdraw = arg1.total_withdraw + arg0;
        arg1.total_withdraw
    }

    fun init(arg0: ARCHIEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = UserReg{
            id    : 0x2::object::new(arg1),
            users : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::public_share_object<UserReg>(v0);
    }

    public fun register(arg0: &mut UserReg, arg1: &mut 0x2::tx_context::TxContext) : UserArchieve {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::table::contains<address, bool>(&arg0.users, v0), 8003);
        let v1 = UserArchieve{
            id                : 0x2::object::new(arg1),
            peg_token_nonce   : 0,
            depeg_token_nonce : 0,
            peg_nft_nonce     : 0,
            depeg_nft_nonce   : 0,
            peg_prey_nonce    : 0,
            depeg_prey_nonce  : 0,
            total_deposit     : 0,
            total_withdraw    : 0,
        };
        0x2::table::add<address, bool>(&mut arg0.users, v0, true);
        v1
    }

    public fun verUpdateNftDepegNonce(arg0: u128, arg1: &mut UserArchieve) {
        assert!(arg1.depeg_nft_nonce < arg0, 8002);
        arg1.depeg_nft_nonce = arg0;
    }

    public fun verUpdateNftPegNonce(arg0: u128, arg1: &mut UserArchieve) {
        assert!(arg1.peg_nft_nonce < arg0, 8002);
        arg1.peg_nft_nonce = arg0;
    }

    public fun verUpdatePreyPegNonce(arg0: u128, arg1: &mut UserArchieve) {
        assert!(arg1.peg_prey_nonce < arg0, 8002);
        arg1.peg_prey_nonce = arg0;
    }

    public fun verUpdateTokenDepegNonce(arg0: u128, arg1: &mut UserArchieve) {
        assert!(arg1.depeg_token_nonce < arg0, 8002);
        arg1.depeg_token_nonce = arg0;
    }

    public fun verUpdateTokenPegNonce(arg0: u128, arg1: &mut UserArchieve) {
        assert!(arg1.peg_token_nonce < arg0, 8002);
        arg1.peg_token_nonce = arg0;
    }

    public fun verifySignature(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x1::option::Option<vector<u8>>) {
        assert!(0x1::option::is_some<vector<u8>>(arg2), 8001);
        assert!(0x2::ed25519::ed25519_verify(&arg0, 0x1::option::borrow<vector<u8>>(arg2), &arg1), 8000);
    }

    // decompiled from Move bytecode v6
}

