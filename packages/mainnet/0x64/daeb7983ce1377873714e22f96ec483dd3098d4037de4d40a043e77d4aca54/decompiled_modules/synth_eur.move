module 0x64daeb7983ce1377873714e22f96ec483dd3098d4037de4d40a043e77d4aca54::synth_eur {
    struct SynthVault has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<SYNTH_EUR>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SynthMinted has copy, drop {
        amount: u64,
        receiver: address,
    }

    struct SynthBurned has copy, drop {
        amount: u64,
    }

    struct SYNTH_EUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYNTH_EUR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let (v1, v2) = 0x2::coin::create_currency<SYNTH_EUR>(arg0, 6, b"sEUR", b"Synthetic EURO", b"a synthetic euro", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYNTH_EUR>>(v2);
        let v3 = SynthVault{
            id  : 0x2::object::new(arg1),
            cap : v1,
        };
        0x2::transfer::public_share_object<SynthVault>(v3);
    }

    public fun mint<T0>(arg0: &mut SynthVault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 13906834608135077887);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 50000, 1);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg1));
        0x2::coin::mint_and_transfer<SYNTH_EUR>(&mut arg0.cap, v1, 0x2::tx_context::sender(arg2), arg2);
        let v2 = SynthMinted{
            amount   : v1,
            receiver : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SynthMinted>(v2);
    }

    public fun onboard_collateral<T0>(arg0: &AdminCap, arg1: &mut SynthVault, arg2: 0x2::coin::Coin<T0>) {
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, 0x1::type_name::get<T0>(), 0x2::coin::into_balance<T0>(arg2));
    }

    public fun redeem<T0>(arg0: &mut SynthVault, arg1: 0x2::coin::Coin<SYNTH_EUR>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 13906834758458933247);
        let v1 = 0x2::coin::value<SYNTH_EUR>(&arg1);
        0x2::tx_context::sender(arg2);
        let v2 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        assert!(0x2::balance::value<T0>(v2) > v1, 2);
        0x2::coin::burn<SYNTH_EUR>(&mut arg0.cap, arg1);
        let v3 = SynthBurned{amount: v1};
        0x2::event::emit<SynthBurned>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v2, v1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

