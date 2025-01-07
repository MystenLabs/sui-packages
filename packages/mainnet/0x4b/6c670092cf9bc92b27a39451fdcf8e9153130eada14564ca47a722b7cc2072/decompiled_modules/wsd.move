module 0x4b6c670092cf9bc92b27a39451fdcf8e9153130eada14564ca47a722b7cc2072::wsd {
    struct Faucet has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<WSD>,
        minted: vector<address>,
        admin: address,
    }

    struct WSD has drop {
        dummy_field: bool,
    }

    public entry fun claim(arg0: &mut Faucet, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.minted, &v0) == false, 0);
        0x2::coin::mint_and_transfer<WSD>(&mut arg0.treasury, 100000000, v0, arg1);
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

    public entry fun mint(arg0: &mut Faucet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin, 1);
        0x2::coin::mint_and_transfer<WSD>(&mut arg0.treasury, 1000000 * arg1 * 100, v0, arg2);
    }

    // decompiled from Move bytecode v6
}

