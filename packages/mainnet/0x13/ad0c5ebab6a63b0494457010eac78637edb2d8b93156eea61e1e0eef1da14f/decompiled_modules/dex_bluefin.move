module 0x13ad0c5ebab6a63b0494457010eac78637edb2d8b93156eea61e1e0eef1da14f::dex_bluefin {
    struct BluefinSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        dex: vector<u8>,
        settlement_time: u64,
    }

    fun execute_bluefin_swap(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0);
        while (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg0)) {
            0x2::coin::join<0x2::sui::SUI>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
        0x2::transfer::public_freeze_object<0x2::coin::Coin<0x2::sui::SUI>>(v0);
    }

    public fun get_bluefin_config() : (u64, u64, u64) {
        (30, 550, 25)
    }

    public fun get_bluefin_package() : address {
        @0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312dd
    }

    public fun get_bluefin_pool() : address {
        @0xe809689d7997a69b3d2596f7f2c5ab4069fd9b33030f79e0b30556b04e1c883
    }

    public fun is_bluefin_available() : bool {
        true
    }

    public entry fun swap_sui_to_usdc_bluefin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 5001);
        assert!(arg1 > 0, 5001);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>();
        0x1::vector::push_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut v1, arg0);
        execute_bluefin_swap(v1, v0, arg1, arg2, arg3);
        let v2 = BluefinSwapExecuted{
            sender          : 0x2::tx_context::sender(arg3),
            amount_in       : v0,
            min_amount_out  : arg1,
            pool_id         : @0xe809689d7997a69b3d2596f7f2c5ab4069fd9b33030f79e0b30556b04e1c883,
            dex             : b"bluefin_dex",
            settlement_time : 550,
        };
        0x2::event::emit<BluefinSwapExecuted>(v2);
    }

    // decompiled from Move bytecode v6
}

