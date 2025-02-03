module 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::xbird {
    struct XBIRD has drop {
        dummy_field: bool,
    }

    struct XBirdAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct XBirdWithdrawn has copy, drop {
        owner: address,
        nonce: u128,
        balance: u64,
    }

    struct XBirdDeposited has copy, drop {
        owner: address,
        nonce: u128,
        balance: u64,
        total_deposit: u64,
    }

    struct PegVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasureCap: 0x2::coin::TreasuryCap<T0>,
        metadata: 0x2::coin::CoinMetadata<T0>,
        burn_nonce: u128,
    }

    struct ValidatorVault has store, key {
        id: 0x2::object::UID,
        validator: 0x1::option::Option<vector<u8>>,
    }

    struct DepositProof {
        owner: address,
        balance: u64,
    }

    fun createPegToken<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<T0>, 0x2::coin::CoinMetadata<T0>) {
        0x2::coin::create_currency<T0>(arg0, 6, b"XBIRD", b"XBIRD", b"Closed Loop Token of BIRDS", 0x1::option::none<0x2::url::Url>(), arg1)
    }

    public fun depositToken(arg0: vector<u8>, arg1: vector<u8>, arg2: &ValidatorVault, arg3: &mut PegVault<XBIRD>, arg4: &mut 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::archieve::UserArchieve, arg5: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<XBIRD>, DepositProof) {
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::checkVersion(arg5, 1);
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::archieve::verifySignature(arg0, arg1, &arg2.validator);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::bcs::new(arg1);
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        let v3 = 0x2::bcs::peel_u128(&mut v1);
        assert!(0x2::bcs::peel_address(&mut v1) == v0, 1001);
        assert!(v2 > 0, 1002);
        assert!(0x2::bcs::peel_u64(&mut v1) > 0x2::clock::timestamp_ms(arg6), 1004);
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::archieve::verUpdateTokenPegNonce(v3, arg4);
        let v4 = DepositProof{
            owner   : v0,
            balance : v2,
        };
        let v5 = XBirdDeposited{
            owner         : v0,
            nonce         : v3,
            balance       : v2,
            total_deposit : 0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::archieve::increaseTotalDeposit(v2, arg4),
        };
        0x2::event::emit<XBirdDeposited>(v5);
        (0x2::coin::mint_balance<XBIRD>(treasureMut<XBIRD>(arg3), v2), v4)
    }

    fun init(arg0: XBIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = createPegToken<XBIRD>(arg0, arg1);
        let v2 = PegVault<XBIRD>{
            id          : 0x2::object::new(arg1),
            treasureCap : v0,
            metadata    : v1,
            burn_nonce  : 0,
        };
        0x2::transfer::public_share_object<PegVault<XBIRD>>(v2);
        let v3 = ValidatorVault{
            id        : 0x2::object::new(arg1),
            validator : 0x1::option::none<vector<u8>>(),
        };
        0x2::transfer::public_share_object<ValidatorVault>(v3);
        let v4 = XBirdAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<XBirdAdminCap>(v4, 0x2::tx_context::sender(arg1));
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::cap_vault::createVault<XBirdAdminCap>(arg1);
    }

    public fun setValidator(arg0: &XBirdAdminCap, arg1: vector<u8>, arg2: &mut ValidatorVault, arg3: &0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::Version) {
        0xfcc8518559a0c8e33610fa6764958377dc25b84ee3ec6acb4cd48591dce77ae3::version::checkVersion(arg3, 1);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    public(friend) fun treasure(arg0: &PegVault<XBIRD>) : &0x2::coin::TreasuryCap<XBIRD> {
        &arg0.treasureCap
    }

    public(friend) fun treasureMut<T0>(arg0: &mut PegVault<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        &mut arg0.treasureCap
    }

    public(friend) fun verifyDepositProof<T0>(arg0: &0x2::balance::Balance<T0>, arg1: DepositProof) {
        assert!(0x2::balance::value<T0>(arg0) == arg1.balance, 1003);
        let DepositProof {
            owner   : _,
            balance : _,
        } = arg1;
    }

    public fun withdrawTo<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut PegVault<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<T0>(&mut arg2.treasureCap, 0x2::coin::from_balance<T0>(arg0, arg3));
        arg2.burn_nonce = arg2.burn_nonce + 1;
        let v0 = XBirdWithdrawn{
            owner   : arg1,
            nonce   : arg2.burn_nonce,
            balance : 0x2::balance::value<T0>(&arg0),
        };
        0x2::event::emit<XBirdWithdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

