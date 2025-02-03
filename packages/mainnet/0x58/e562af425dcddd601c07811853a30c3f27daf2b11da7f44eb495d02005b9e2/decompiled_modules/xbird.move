module 0x58e562af425dcddd601c07811853a30c3f27daf2b11da7f44eb495d02005b9e2::xbird {
    struct XBIRD has drop {
        dummy_field: bool,
    }

    struct XBirdAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct XBirdWithdrawn has copy, drop {
        owner: address,
        amount: u64,
        nonce: u128,
        balance: u64,
    }

    struct XBirdDeposited has copy, drop {
        owner: address,
        amount: u64,
        nonce: u128,
        balance: u64,
    }

    struct PegVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasureCap: 0x2::coin::TreasuryCap<T0>,
        metadata: 0x2::coin::CoinMetadata<T0>,
    }

    struct ValidatorVault has store, key {
        id: 0x2::object::UID,
        validator: 0x1::option::Option<vector<u8>>,
    }

    fun createPegToken<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<T0>, 0x2::coin::CoinMetadata<T0>) {
        0x2::coin::create_currency<T0>(arg0, 6, b"XBIRD", b"XBIRD", b"Closed Loop Token of BIRDS", 0x1::option::none<0x2::url::Url>(), arg1)
    }

    public fun depositToken(arg0: vector<u8>, arg1: vector<u8>, arg2: &ValidatorVault, arg3: &mut PegVault<XBIRD>, arg4: &mut 0x58e562af425dcddd601c07811853a30c3f27daf2b11da7f44eb495d02005b9e2::archieve::UserArchieve, arg5: &0x58e562af425dcddd601c07811853a30c3f27daf2b11da7f44eb495d02005b9e2::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x58e562af425dcddd601c07811853a30c3f27daf2b11da7f44eb495d02005b9e2::version::checkVersion(arg5, 1);
        0x58e562af425dcddd601c07811853a30c3f27daf2b11da7f44eb495d02005b9e2::archieve::verifySignature(arg0, arg1, &arg2.validator);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::bcs::new(arg1);
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        let v3 = 0x2::bcs::peel_u128(&mut v1);
        assert!(0x2::bcs::peel_address(&mut v1) == v0, 1001);
        assert!(v2 > 0, 1002);
        0x58e562af425dcddd601c07811853a30c3f27daf2b11da7f44eb495d02005b9e2::archieve::verUpdateTokenPegNonce(v3, arg4);
        let v4 = treasureMut<XBIRD>(arg3);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<XBIRD>(treasureMut<XBIRD>(arg3), 0x2::token::transfer<XBIRD>(0x2::token::mint<XBIRD>(v4, v2, arg6), v0, arg6), arg6);
        let v9 = XBirdDeposited{
            owner   : v0,
            amount  : v2,
            nonce   : v3,
            balance : 0x58e562af425dcddd601c07811853a30c3f27daf2b11da7f44eb495d02005b9e2::archieve::increaseTotalDeposit(v2, arg4),
        };
        0x2::event::emit<XBirdDeposited>(v9);
    }

    fun init(arg0: XBIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = createPegToken<XBIRD>(arg0, arg1);
        let v2 = PegVault<XBIRD>{
            id          : 0x2::object::new(arg1),
            treasureCap : v0,
            metadata    : v1,
        };
        0x2::transfer::public_share_object<PegVault<XBIRD>>(v2);
        let v3 = ValidatorVault{
            id        : 0x2::object::new(arg1),
            validator : 0x1::option::none<vector<u8>>(),
        };
        0x2::transfer::public_share_object<ValidatorVault>(v3);
        let v4 = XBirdAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<XBirdAdminCap>(v4, 0x2::tx_context::sender(arg1));
        0x58e562af425dcddd601c07811853a30c3f27daf2b11da7f44eb495d02005b9e2::cap_vault::createVault<XBirdAdminCap>(arg1);
    }

    fun mintToSender(arg0: &mut 0x2::coin::TreasuryCap<XBIRD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<XBIRD>(arg0, 0x2::token::transfer<XBIRD>(0x2::token::mint<XBIRD>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2), arg2), arg2);
        0x2::coin::mint_and_transfer<XBIRD>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    public fun setValidator(arg0: &XBirdAdminCap, arg1: vector<u8>, arg2: &mut ValidatorVault, arg3: &0x58e562af425dcddd601c07811853a30c3f27daf2b11da7f44eb495d02005b9e2::version::Version) {
        0x58e562af425dcddd601c07811853a30c3f27daf2b11da7f44eb495d02005b9e2::version::checkVersion(arg3, 1);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    public(friend) fun treasure(arg0: &PegVault<XBIRD>) : &0x2::coin::TreasuryCap<XBIRD> {
        &arg0.treasureCap
    }

    public(friend) fun treasureMut<T0>(arg0: &mut PegVault<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        &mut arg0.treasureCap
    }

    public fun withdrawToken(arg0: &mut PegVault<XBIRD>, arg1: &mut 0x58e562af425dcddd601c07811853a30c3f27daf2b11da7f44eb495d02005b9e2::archieve::UserArchieve, arg2: 0x2::token::Token<XBIRD>, arg3: &0x58e562af425dcddd601c07811853a30c3f27daf2b11da7f44eb495d02005b9e2::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x58e562af425dcddd601c07811853a30c3f27daf2b11da7f44eb495d02005b9e2::version::checkVersion(arg3, 1);
        let v0 = 0x2::token::value<XBIRD>(&arg2);
        let v1 = XBirdWithdrawn{
            owner   : 0x2::tx_context::sender(arg4),
            amount  : v0,
            nonce   : 0x58e562af425dcddd601c07811853a30c3f27daf2b11da7f44eb495d02005b9e2::archieve::increaseGetTokenDepegNonce(arg1),
            balance : 0x58e562af425dcddd601c07811853a30c3f27daf2b11da7f44eb495d02005b9e2::archieve::increaseTotalWithdraw(v0, arg1),
        };
        0x2::event::emit<XBirdWithdrawn>(v1);
        0x2::token::burn<XBIRD>(treasureMut<XBIRD>(arg0), arg2);
    }

    // decompiled from Move bytecode v6
}

