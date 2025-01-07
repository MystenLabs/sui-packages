module 0xfd48ffd0e62ed5cb839400b7e0bee870cd752f9d01c657a665be2afff16995eb::jkart {
    struct JKART has drop {
        dummy_field: bool,
    }

    struct JKARTSWAP has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<JKART>,
        store: vector<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::jellyfish::JellyFish>,
    }

    public fun total_supply(arg0: &JKARTSWAP) : u64 {
        0x2::coin::total_supply<JKART>(&arg0.cap)
    }

    public fun get_decimals() : u8 {
        0
    }

    fun init(arg0: JKART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JKART>(arg0, 0, b"jKARTCOIN", b"jKART", b"jKART Coin for JellyPi in KartScription Protocal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://n6c64tk5plrwfql37r3izpx6nhxtk2x3myxm52gv5m2octt4jzwq.arweave.net/b4XuTV1642LBe_x2jL7-ae81avtmLs7o1es04U58Tm0")), arg1);
        let v2 = JKARTSWAP{
            id    : 0x2::object::new(arg1),
            cap   : v0,
            store : 0x1::vector::empty<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::jellyfish::JellyFish>(),
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JKART>>(v1);
        0x2::transfer::share_object<JKARTSWAP>(v2);
    }

    public fun jf_to_jkart_coin(arg0: &mut JKARTSWAP, arg1: 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::jellyfish::JellyFish, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JKART> {
        if (0x1::vector::is_empty<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::jellyfish::JellyFish>(&arg0.store)) {
            0x1::vector::push_back<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::jellyfish::JellyFish>(&mut arg0.store, arg1);
        } else {
            0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::jellyfish::do_merge(0x1::vector::borrow_mut<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::jellyfish::JellyFish>(&mut arg0.store, 0), arg1);
        };
        0x2::coin::mint<JKART>(&mut arg0.cap, 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::jellyfish::amount(&arg1), arg2)
    }

    public entry fun jf_to_jkart_coin_swap(arg0: &mut JKARTSWAP, arg1: 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::jellyfish::JellyFish, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = jf_to_jkart_coin(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<JKART>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun jkart_coin_to_jf(arg0: &mut JKARTSWAP, arg1: 0x2::coin::Coin<JKART>, arg2: &mut 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::jellyfish::SplitRepo, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::jellyfish::JellyFish {
        let v0 = 0x2::coin::burn<JKART>(&mut arg0.cap, arg1);
        assert!(v0 > 0, 1);
        if (0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::jellyfish::amount(0x1::vector::borrow<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::jellyfish::JellyFish>(&arg0.store, 0)) == v0) {
            0x1::vector::pop_back<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::jellyfish::JellyFish>(&mut arg0.store)
        } else {
            0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::jellyfish::do_split(0x1::vector::borrow_mut<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::jellyfish::JellyFish>(&mut arg0.store, 0), arg2, arg3, v0, arg4)
        }
    }

    public entry fun jkart_coin_to_jf_swap(arg0: &mut JKARTSWAP, arg1: 0x2::coin::Coin<JKART>, arg2: &mut 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::jellyfish::SplitRepo, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = jkart_coin_to_jf(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::jellyfish::JellyFish>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun total_store(arg0: &JKARTSWAP) : u64 {
        if (0x1::vector::length<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::jellyfish::JellyFish>(&arg0.store) > 0) {
            0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::jellyfish::amount(0x1::vector::borrow<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::jellyfish::JellyFish>(&arg0.store, 0))
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

