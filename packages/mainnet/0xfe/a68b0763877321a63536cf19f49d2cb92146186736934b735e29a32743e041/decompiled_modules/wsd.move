module 0xfea68b0763877321a63536cf19f49d2cb92146186736934b735e29a32743e041::wsd {
    struct Faucet has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<WSD>,
        minted: vector<address>,
        admin: address,
    }

    struct WSD has drop {
        dummy_field: bool,
    }

    public fun claim(arg0: &mut Faucet, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.minted, &v0) == false, 0);
        0x2::coin::mint_and_transfer<WSD>(&mut arg0.treasury, 1000000, v0, arg1);
        0x1::vector::push_back<address>(&mut arg0.minted, v0);
    }

    fun init(arg0: WSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSD>(arg0, 6, b"WSD", b"WSD", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WSD>>(v1);
        let v2 = Faucet{
            id       : 0x2::object::new(arg1),
            treasury : v0,
            minted   : 0x1::vector::empty<address>(),
            admin    : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Faucet>(v2);
    }

    public fun mint(arg0: &mut Faucet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin, 1);
        0x2::coin::mint_and_transfer<WSD>(&mut arg0.treasury, 1000000 * arg1, v0, arg2);
    }

    // decompiled from Move bytecode v6
}

