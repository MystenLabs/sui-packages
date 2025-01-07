module 0xef8e3455f41a7485f7afa6409c2216071160a247b1198a55382151f9ed2a4d5::toma {
    struct TOMA has drop {
        dummy_field: bool,
    }

    struct PublishedEvent has copy, drop {
        faucet: 0x2::object::ID,
        treasury: 0x2::object::ID,
        metadata: 0x2::object::ID,
    }

    struct Faucet has store, key {
        id: 0x2::object::UID,
        treasury: 0x1::option::Option<0x2::coin::TreasuryCap<TOMA>>,
    }

    entry fun disable_faucet(arg0: &mut Faucet, arg1: &0x2::package::Publisher, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<TOMA>(arg1), 9223372328912551935);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMA>>(0x1::option::extract<0x2::coin::TreasuryCap<TOMA>>(&mut arg0.treasury), 0x2::tx_context::sender(arg2));
    }

    entry fun enable_faucet(arg0: &mut Faucet, arg1: 0x2::coin::TreasuryCap<TOMA>) {
        0x1::option::fill<0x2::coin::TreasuryCap<TOMA>>(&mut arg0.treasury, arg1);
    }

    entry fun faucet(arg0: &mut Faucet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TOMA>>(0x2::coin::mint<TOMA>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<TOMA>>(&mut arg0.treasury), arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: TOMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMA>(arg0, 9, b"TOMA", b"TOMA", b"Atoma network coin", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = Faucet{
            id       : 0x2::object::new(arg1),
            treasury : 0x1::option::none<0x2::coin::TreasuryCap<TOMA>>(),
        };
        let v5 = PublishedEvent{
            faucet   : 0x2::object::id<Faucet>(&v4),
            treasury : 0x2::object::id<0x2::coin::TreasuryCap<TOMA>>(&v3),
            metadata : 0x2::object::id<0x2::coin::CoinMetadata<TOMA>>(&v2),
        };
        0x2::event::emit<PublishedEvent>(v5);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOMA>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Faucet>(v4);
    }

    // decompiled from Move bytecode v6
}

