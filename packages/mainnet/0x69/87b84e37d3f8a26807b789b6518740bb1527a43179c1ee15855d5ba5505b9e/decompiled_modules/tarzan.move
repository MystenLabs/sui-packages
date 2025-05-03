module 0x6987b84e37d3f8a26807b789b6518740bb1527a43179c1ee15855d5ba5505b9e::tarzan {
    struct Flavor has key {
        id: 0x2::object::UID,
        restricted: vector<address>,
    }

    struct Freezer has key {
        id: 0x2::object::UID,
    }

    struct RestrictionEvent has copy, drop {
        wallet: address,
        restricted: bool,
    }

    struct TARZAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARZAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARZAN>(arg0, 9, b"TARZAN", b"Tarzan Token", b"Token with transfer rules", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = Freezer{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<Freezer>(v3, 0x2::tx_context::sender(arg1));
        let v4 = Flavor{
            id         : 0x2::object::new(arg1),
            restricted : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<Flavor>(v4);
        0x2::coin::mint_and_transfer<TARZAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TARZAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARZAN>>(v2, @0x0);
    }

    public entry fun restrict_wallet(arg0: &Freezer, arg1: &mut Flavor, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::contains<address>(&arg1.restricted, &arg2), 0);
        0x1::vector::push_back<address>(&mut arg1.restricted, arg2);
        let v0 = RestrictionEvent{
            wallet     : arg2,
            restricted : true,
        };
        0x2::event::emit<RestrictionEvent>(v0);
    }

    public fun transfer_hook(arg0: &Flavor, arg1: address, arg2: address, arg3: u64) {
        assert!(!0x1::vector::contains<address>(&arg0.restricted, &arg1), 0);
    }

    public entry fun unrestrict_wallet(arg0: &Freezer, arg1: &mut Flavor, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.restricted, &arg2);
        assert!(v0, 0);
        0x1::vector::remove<address>(&mut arg1.restricted, v1);
        let v2 = RestrictionEvent{
            wallet     : arg2,
            restricted : false,
        };
        0x2::event::emit<RestrictionEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

