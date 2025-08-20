module 0x21700f31d563949214e0411f22a3cf64928f6a3e5b3c13f830a30d6884fe135b::memez_wallet {
    struct MEMEZ_WALLET has drop {
        dummy_field: bool,
    }

    struct MemezWallet has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct MemezWalletRegistry has key {
        id: 0x2::object::UID,
        wallets: 0x2::table::Table<address, address>,
    }

    public fun new(arg0: &mut MemezWalletRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : MemezWallet {
        assert!(!0x2::table::contains<address, address>(&arg0.wallets, arg1), 1);
        let v0 = MemezWallet{
            id    : 0x2::object::new(arg2),
            owner : arg1,
        };
        0x2::table::add<address, address>(&mut arg0.wallets, arg1, 0x2::object::uid_to_address(&v0.id));
        v0
    }

    fun assert_is_owner(arg0: &MemezWallet, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
    }

    fun init(arg0: MEMEZ_WALLET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MemezWalletRegistry{
            id      : 0x2::object::new(arg1),
            wallets : 0x2::table::new<address, address>(arg1),
        };
        0x2::transfer::share_object<MemezWalletRegistry>(v0);
        0x2::package::claim_and_keep<MEMEZ_WALLET>(arg0, arg1);
    }

    fun merge<T0>(arg0: &mut MemezWallet, arg1: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg2);
        0x1::vector::reverse<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg1)) {
            let v2 = v0;
            0x2::coin::join<T0>(&mut v2, 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, 0x1::vector::pop_back<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&mut arg1)));
            v0 = v2;
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(arg1);
        v0
    }

    public fun merge_coins<T0>(arg0: &mut MemezWallet, arg1: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = merge<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::object::uid_to_address(&arg0.id));
    }

    public fun receive<T0: store + key>(arg0: &mut MemezWallet, arg1: 0x2::transfer::Receiving<T0>, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        assert_is_owner(arg0, arg2);
        0x2::transfer::public_receive<T0>(&mut arg0.id, arg1)
    }

    public fun receive_coins<T0>(arg0: &mut MemezWallet, arg1: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_is_owner(arg0, arg2);
        merge<T0>(arg0, arg1, arg2)
    }

    public fun share(arg0: MemezWallet) {
        0x2::transfer::share_object<MemezWallet>(arg0);
    }

    public fun wallet_address(arg0: &MemezWalletRegistry, arg1: address) : 0x1::option::Option<address> {
        if (0x2::table::contains<address, address>(&arg0.wallets, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<address, address>(&arg0.wallets, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    // decompiled from Move bytecode v6
}

