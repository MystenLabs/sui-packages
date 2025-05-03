module 0x98faea667d6eb74c46f1d4e955905b8fa600da7ea6f14e4f558b7fd223232eea::tarzan {
    struct TokenGuard has key {
        id: 0x2::object::UID,
        frozen_wallets: vector<address>,
    }

    struct AdminKey has key {
        id: 0x2::object::UID,
    }

    struct TransferLock has store, key {
        id: 0x2::object::UID,
    }

    struct TARZAN has drop {
        dummy_field: bool,
    }

    struct WalletEvent has copy, drop {
        wallet: address,
        frozen: bool,
        timestamp: u64,
    }

    public entry fun freeze_wallet(arg0: &AdminKey, arg1: &mut TokenGuard, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::contains<address>(&arg1.frozen_wallets, &arg2), 0);
        0x1::vector::push_back<address>(&mut arg1.frozen_wallets, arg2);
        let v0 = TransferLock{id: 0x2::object::new(arg3)};
        0x2::transfer::public_transfer<TransferLock>(v0, arg2);
        let v1 = WalletEvent{
            wallet    : arg2,
            frozen    : true,
            timestamp : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<WalletEvent>(v1);
    }

    fun init(arg0: TARZAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARZAN>(arg0, 9, b"TARZAN", b"Tarzan Token", b"Token with transfer controls", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = AdminKey{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminKey>(v3, 0x2::tx_context::sender(arg1));
        let v4 = TokenGuard{
            id             : 0x2::object::new(arg1),
            frozen_wallets : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<TokenGuard>(v4);
        0x2::coin::mint_and_transfer<TARZAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TARZAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARZAN>>(v2, @0x0);
    }

    public fun transfer_hook(arg0: &TokenGuard, arg1: address, arg2: address, arg3: u64) {
        assert!(!0x1::vector::contains<address>(&arg0.frozen_wallets, &arg1), 0);
    }

    public entry fun unfreeze_wallet(arg0: &AdminKey, arg1: &mut TokenGuard, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.frozen_wallets, &arg2);
        assert!(v0, 0);
        0x1::vector::remove<address>(&mut arg1.frozen_wallets, v1);
        let v2 = WalletEvent{
            wallet    : arg2,
            frozen    : false,
            timestamp : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<WalletEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

