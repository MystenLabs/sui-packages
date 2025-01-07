module 0xda12d621169da92ed8af5f6b332b7bec64c840bb49bb3d4206d6739cd76bad14::xfantv {
    struct XFANTV has drop {
        dummy_field: bool,
    }

    struct CoinStore has key {
        id: 0x2::object::UID,
        coin_treasury: 0x2::coin::TreasuryCap<XFANTV>,
    }

    struct Wallet has store, key {
        id: 0x2::object::UID,
        beneficiary: address,
        amount: u64,
    }

    struct SuperAdminCap has key {
        id: 0x2::object::UID,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        admins: vector<address>,
    }

    struct WalletCap has key {
        id: 0x2::object::UID,
    }

    struct MaxCredit has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct SpendCoin has drop {
        dummy_field: bool,
    }

    struct TokenCredited has copy, drop {
        beneficiary: address,
        amount: u64,
    }

    struct TokenMinted has copy, drop {
        beneficiary: address,
        amount: u64,
    }

    struct TokenDebited has copy, drop {
        spender: address,
        amount: u64,
    }

    struct AdminAdded has copy, drop {
        admin: address,
    }

    struct AdminRemoved has copy, drop {
        admin: address,
    }

    struct WalletCapGranted has copy, drop {
        to_address: address,
    }

    public fun add_admin(arg0: &mut AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 2);
        0x1::vector::push_back<address>(&mut arg0.admins, arg1);
        let v0 = AdminAdded{admin: arg1};
        0x2::event::emit<AdminAdded>(v0);
    }

    public fun claim_token(arg0: &mut Wallet, arg1: &mut CoinStore, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.amount > 0, 0);
        let v0 = TokenMinted{
            beneficiary : arg0.beneficiary,
            amount      : arg0.amount,
        };
        0x2::event::emit<TokenMinted>(v0);
        arg0.amount = 0;
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<XFANTV>(&mut arg1.coin_treasury, 0x2::token::transfer<XFANTV>(0x2::token::mint<XFANTV>(&mut arg1.coin_treasury, arg0.amount, arg2), arg0.beneficiary, arg2), arg2);
    }

    public fun ern_xft(arg0: &AdminCap, arg1: &MaxCredit, arg2: &mut Wallet, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg4)), 2);
        assert!(arg3 < arg1.amount, 1);
        arg2.amount = arg2.amount + arg3;
        let v0 = TokenCredited{
            beneficiary : arg2.beneficiary,
            amount      : arg3,
        };
        0x2::event::emit<TokenCredited>(v0);
    }

    public fun grant_wallet_cap(arg0: &SuperAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = WalletCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<WalletCap>(v0, arg1);
        let v1 = WalletCapGranted{to_address: arg1};
        0x2::event::emit<WalletCapGranted>(v1);
    }

    fun init(arg0: XFANTV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XFANTV>(arg0, 9, b"$FAN", b"xFanTV", b"xFanTV represents the platform token linked to FanTV, offering ownership in the platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1715789262935-FanTV.png")), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<XFANTV>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        0x2::token::add_rule_for_action<XFANTV, SpendCoin>(&mut v6, &v5, 0x2::token::spend_action(), arg1);
        0x2::token::share_policy<XFANTV>(v6);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<XFANTV>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XFANTV>>(v1, 0x2::tx_context::sender(arg1));
        let v7 = SuperAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SuperAdminCap>(v7, 0x2::tx_context::sender(arg1));
        let v8 = WalletCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<WalletCap>(v8, 0x2::tx_context::sender(arg1));
        let v9 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v9, 0x2::tx_context::sender(arg1));
        let v10 = AdminCap{
            id     : 0x2::object::new(arg1),
            admins : v9,
        };
        let v11 = MaxCredit{
            id     : 0x2::object::new(arg1),
            amount : 0,
        };
        0x2::transfer::share_object<AdminCap>(v10);
        0x2::transfer::share_object<MaxCredit>(v11);
        let v12 = CoinStore{
            id            : 0x2::object::new(arg1),
            coin_treasury : v2,
        };
        0x2::transfer::share_object<CoinStore>(v12);
    }

    public fun init_wallet(arg0: &WalletCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Wallet{
            id          : 0x2::object::new(arg2),
            beneficiary : arg1,
            amount      : 0,
        };
        0x2::transfer::share_object<Wallet>(v0);
    }

    fun is_admin(arg0: &AdminCap, arg1: address) : bool {
        let (v0, _) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        v0
    }

    public fun mint_and_transfer(arg0: &SuperAdminCap, arg1: &mut CoinStore, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<XFANTV>(&mut arg1.coin_treasury, 0x2::token::transfer<XFANTV>(0x2::token::mint<XFANTV>(&mut arg1.coin_treasury, arg2, arg4), arg3, arg4), arg4);
        let v4 = TokenMinted{
            beneficiary : arg3,
            amount      : arg2,
        };
        0x2::event::emit<TokenMinted>(v4);
    }

    public fun remove_admin(arg0: &mut AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 2);
        assert!(is_admin(arg0, arg1), 2);
        let (_, v1) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        0x1::vector::remove<address>(&mut arg0.admins, v1);
        let v2 = AdminRemoved{admin: arg1};
        0x2::event::emit<AdminRemoved>(v2);
    }

    public fun spnd_xft(arg0: 0x2::token::Token<XFANTV>, arg1: &mut CoinStore, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenDebited{
            spender : 0x2::tx_context::sender(arg2),
            amount  : 0x2::token::value<XFANTV>(&arg0),
        };
        0x2::event::emit<TokenDebited>(v0);
        let v1 = 0x2::token::spend<XFANTV>(arg0, arg2);
        let v2 = SpendCoin{dummy_field: false};
        0x2::token::add_approval<XFANTV, SpendCoin>(v2, &mut v1, arg2);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<XFANTV>(&mut arg1.coin_treasury, v1, arg2);
    }

    public fun update_max_credit(arg0: &SuperAdminCap, arg1: u64, arg2: &mut MaxCredit) {
        arg2.amount = arg1;
    }

    // decompiled from Move bytecode v6
}

