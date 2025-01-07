module 0x16ea6f562eb4cb4d6f5e00dd16f4d3144e6f5014a3ca57bbee0b5469d7fa54d3::but {
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

    public fun borrow_cap(arg0: &ButBurner, arg1: &0x2::coin::CoinMetadata<BUT>) : &0x2::coin::TreasuryCap<BUT> {
        &arg0.cap
    }

    fun init(arg0: BUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUT>(arg0, 9, b"TESTING_BUT", b"Testing Bucket Token", b"Governance token of Bucket Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aqua-natural-grasshopper-705.mypinata.cloud/ipfs/QmUKAX4PME9Wb9VU6CMJPisNysaVKZNKpiB3gtMVVZTfjt")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUT>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = ButBurner{
            id  : 0x2::object::new(arg1),
            cap : v2,
        };
        0x2::transfer::share_object<ButBurner>(v3);
    }

    // decompiled from Move bytecode v6
}

