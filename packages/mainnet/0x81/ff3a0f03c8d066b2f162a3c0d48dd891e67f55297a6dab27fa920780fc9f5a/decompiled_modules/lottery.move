module 0x81ff3a0f03c8d066b2f162a3c0d48dd891e67f55297a6dab27fa920780fc9f5a::lottery {
    struct LOTTERY has drop {
        dummy_field: bool,
    }

    struct StoredSUI has store, key {
        id: 0x2::object::UID,
        coins: vector<0x2::coin::Coin<0x2::sui::SUI>>,
        admin: address,
    }

    struct RandomNum has copy, drop {
        balance: u64,
        min: u64,
        max: u64,
        rate: u64,
        random_num: u64,
    }

    fun init(arg0: LOTTERY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StoredSUI{
            id    : 0x2::object::new(arg1),
            coins : 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>(),
            admin : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_share_object<StoredSUI>(v0);
    }

    entry fun play(arg0: &0x2::clock::Clock, arg1: &mut StoredSUI, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::coin::TreasuryCap<0xe03c047a1c85887ed3a3c4b775d0d74c752dfce736705e5abacbbc3ddf27bf8b::july_nana_faucet_token::JULY_NANA_FAUCET_TOKEN>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::balance<0x2::sui::SUI>(&arg2);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(v0);
        assert!(0x2::balance::value<0x2::sui::SUI>(v0) >= 100000, 0);
        0x1::vector::push_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.coins, arg2);
        let v2 = 1000000000 / 100000000;
        let v3 = 0x81ff3a0f03c8d066b2f162a3c0d48dd891e67f55297a6dab27fa920780fc9f5a::utils::generate_random_in_range(arg4, arg0, v1 / v2, v1 * 2 / v2);
        let v4 = RandomNum{
            balance    : v1,
            min        : v1 / v2,
            max        : v1 * 2 / v2,
            rate       : v2,
            random_num : v3,
        };
        0x2::event::emit<RandomNum>(v4);
        0xe03c047a1c85887ed3a3c4b775d0d74c752dfce736705e5abacbbc3ddf27bf8b::july_nana_faucet_token::mint(arg3, v3, 0x2::tx_context::sender(arg4), arg4);
    }

    entry fun withdrow(arg0: &mut StoredSUI, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
        while (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg0.coins)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.coins), arg0.admin);
        };
    }

    // decompiled from Move bytecode v6
}

