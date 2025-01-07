module 0x138a2f2c14aaacfa5724e9295de5a000147bf9697f17c085e76b19749e1e7a83::Minter {
    struct MINTER has drop {
        dummy_field: bool,
    }

    struct MinterAdminCap has key {
        id: 0x2::object::UID,
    }

    struct Minter has key {
        id: 0x2::object::UID,
        price: u64,
        publisher: 0x2::package::Publisher,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Minted<phantom T0> has copy, drop {
        sender: address,
    }

    fun init(arg0: MINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Minter{
            id          : 0x2::object::new(arg1),
            price       : 1000000000,
            publisher   : 0x2::package::claim<MINTER>(arg0, arg1),
            sui_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Minter>(v0);
        let v1 = MinterAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MinterAdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_egg<T0>(arg0: &mut Minter, arg1: &mut 0x138a2f2c14aaacfa5724e9295de5a000147bf9697f17c085e76b19749e1e7a83::PEPESEGG::PepeEggStorage, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = split_coin_vec<0x2::sui::SUI>(arg2, arg0.price, arg3);
        let v2 = v0;
        assert!(0x2::coin::value<0x2::sui::SUI>(&v2) == arg0.price, 2);
        0x138a2f2c14aaacfa5724e9295de5a000147bf9697f17c085e76b19749e1e7a83::PEPESEGG::mint_egg(arg1, &arg0.publisher, 0x2::tx_context::sender(arg3), arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(v2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun split_coin_vec<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::zero<T0>(arg2);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        (0x2::coin::split<T0>(&mut v0, arg1, arg2), v0)
    }

    public entry fun transfer_private_s_funds<T0>(arg0: &MinterAdminCap, arg1: &mut Minter, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance)), arg3), arg2);
    }

    public entry fun update_nft_price(arg0: &MinterAdminCap, arg1: &mut Minter, arg2: u64) {
        arg1.price = arg2;
    }

    // decompiled from Move bytecode v6
}

