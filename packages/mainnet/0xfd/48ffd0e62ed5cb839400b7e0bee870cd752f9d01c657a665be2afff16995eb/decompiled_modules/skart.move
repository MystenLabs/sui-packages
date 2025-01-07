module 0xfd48ffd0e62ed5cb839400b7e0bee870cd752f9d01c657a665be2afff16995eb::skart {
    struct SKART has drop {
        dummy_field: bool,
    }

    struct SKARTSWAP has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<SKART>,
        store: vector<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>,
    }

    public fun total_supply(arg0: &SKARTSWAP) : u64 {
        0x2::coin::total_supply<SKART>(&arg0.cap)
    }

    public fun get_decimals() : u8 {
        9
    }

    fun init(arg0: SKART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKART>(arg0, 9, b"sKARTCOIN", b"sKART", b"sKART Coin for KartScription in KartScription Protocal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://osp3bhhpqkgtrtuww3cn6cqpcy36lxhu2j4djhbr5fu4fzusrt2a.arweave.net/dJ-wnO-CjTjOlrbE3woPFjfl3PTSeDScMelpwuaSjPQ")), arg1);
        let v2 = SKARTSWAP{
            id    : 0x2::object::new(arg1),
            cap   : v0,
            store : 0x1::vector::empty<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(),
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKART>>(v1);
        0x2::transfer::share_object<SKARTSWAP>(v2);
    }

    public fun ks_to_skart_coin(arg0: &mut SKARTSWAP, arg1: 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SKART> {
        if (0x1::vector::is_empty<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(&arg0.store)) {
            0x1::vector::push_back<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(&mut arg0.store, arg1);
        } else {
            0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::do_merge(0x1::vector::borrow_mut<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(&mut arg0.store, 0), arg1, arg2);
        };
        0x2::coin::mint<SKART>(&mut arg0.cap, 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::kart_value(&arg1), arg2)
    }

    public entry fun ks_to_skart_coin_swap(arg0: &mut SKARTSWAP, arg1: 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ks_to_skart_coin(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SKART>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun skart_coin_to_ks(arg0: &mut SKARTSWAP, arg1: 0x2::coin::Coin<SKART>, arg2: &mut 0x2::tx_context::TxContext) : 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription {
        let v0 = 0x2::coin::burn<SKART>(&mut arg0.cap, arg1);
        assert!(v0 > 0, 1);
        if (0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::kart_value(0x1::vector::borrow<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(&arg0.store, 0)) == v0) {
            0x1::vector::pop_back<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(&mut arg0.store)
        } else {
            0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::do_split(0x1::vector::borrow_mut<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(&mut arg0.store, 0), v0, arg2)
        }
    }

    public entry fun skart_coin_to_ks_swap(arg0: &mut SKARTSWAP, arg1: 0x2::coin::Coin<SKART>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = skart_coin_to_ks(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun total_store(arg0: &SKARTSWAP) : u64 {
        if (0x1::vector::length<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(&arg0.store) > 0) {
            0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::kart_value(0x1::vector::borrow<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(&arg0.store, 0))
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

