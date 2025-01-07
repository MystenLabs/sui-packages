module 0xbc858cb910b9914bee64fff0f9b38855355a040c49155a17b265d9086d256545::but {
    struct BUT has drop {
        dummy_field: bool,
    }

    struct ButBurner has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<BUT>,
    }

    public fun burn(arg0: &mut ButBurner, arg1: 0x2::coin::Coin<BUT>) {
        0x2::coin::burn<BUT>(&mut arg0.cap, arg1);
    }

    public fun total_supply(arg0: &ButBurner) : u64 {
        0x2::coin::total_supply<BUT>(&arg0.cap)
    }

    public fun borrow_cap(arg0: &ButBurner, arg1: &0x2::coin::CoinMetadata<BUT>) : &0x2::coin::TreasuryCap<BUT> {
        &arg0.cap
    }

    fun init(arg0: BUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUT>(arg0, 9, b"BUT", b"Bucket Token", b"Governance token of Bucket Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aqua-natural-grasshopper-705.mypinata.cloud/ipfs/QmUKAX4PME9Wb9VU6CMJPisNysaVKZNKpiB3gtMVVZTfjt")), arg1);
        let v2 = v0;
        let v3 = 0x2::coin::mint<BUT>(&mut v2, 1000000000000000000, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BUT>>(0x2::coin::split<BUT>(&mut v3, 330000000000000000, arg1), @0xa0ce1f88c89febfae59cf553797c766bc7178113748e5333cf063545182768ac);
        0x2::transfer::public_transfer<0x2::coin::Coin<BUT>>(0x2::coin::split<BUT>(&mut v3, 100000000000000000, arg1), @0xa9d02ff2f7047fc1cc2eec351f0274a054590b9ea840e77245336a4305f9b194);
        0x2::transfer::public_transfer<0x2::coin::Coin<BUT>>(0x2::coin::split<BUT>(&mut v3, 50000000000000000, arg1), @0xfbf80a562841ecf0f38eec71d00c5e714f931b12ffbd786173c7071e104a5df9);
        assert!(0x2::coin::value<BUT>(&v3) == 1000000000000000000 - 330000000000000000 - 100000000000000000 - 50000000000000000, 9223372328912551935);
        0x2::transfer::public_transfer<0x2::coin::Coin<BUT>>(v3, @0x19f528cf4b5d0d8bcbc33c66405d149ea726a4dc1bc773537dc65364d4e58be4);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUT>>(v1, @0x19f528cf4b5d0d8bcbc33c66405d149ea726a4dc1bc773537dc65364d4e58be4);
        let v4 = ButBurner{
            id  : 0x2::object::new(arg1),
            cap : v2,
        };
        0x2::transfer::share_object<ButBurner>(v4);
    }

    public fun max_supply() : u64 {
        1000000000000000000
    }

    // decompiled from Move bytecode v6
}

