module 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice {
    struct Spice has store, key {
        id: 0x2::object::UID,
        serial: u64,
        minted_ms: u64,
        seal_serial: u64,
    }

    struct MintBook has key {
        id: 0x2::object::UID,
        minted: u64,
        paused: bool,
        rebate_vault: 0x1::option::Option<0x2::object::ID>,
    }

    struct SpiceMinted has copy, drop {
        spice_id: 0x2::object::ID,
        serial: u64,
        seal_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        minter: address,
    }

    public fun serial(arg0: &Spice) : u64 {
        arg0.serial
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : MintBook {
        MintBook{
            id           : 0x2::object::new(arg0),
            minted       : 0,
            paused       : false,
            rebate_vault : 0x1::option::none<0x2::object::ID>(),
        }
    }

    public fun is_paused(arg0: &MintBook) : bool {
        arg0.paused
    }

    public fun max_per_tx() : u64 {
        100
    }

    public fun mint(arg0: &mut MintBook, arg1: &0x2::transfer_policy::TransferPolicy<Spice>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        assert!(!arg0.paused, 1);
        mint_inner(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun mint_inner(arg0: &mut MintBook, arg1: &0x2::transfer_policy::TransferPolicy<Spice>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        assert!(arg5 > 0 && arg5 <= 100, 3);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < arg5) {
            arg0.minted = arg0.minted + 1;
            let v2 = Spice{
                id          : 0x2::object::new(arg7),
                serial      : arg0.minted,
                minted_ms   : 0x2::clock::timestamp_ms(arg6),
                seal_serial : 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::serial(0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::prove(arg2, arg3, arg4)),
            };
            let v3 = 0x2::object::id<Spice>(&v2);
            let v4 = SpiceMinted{
                spice_id : v3,
                serial   : v2.serial,
                seal_id  : arg4,
                kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
                minter   : 0x2::tx_context::sender(arg7),
            };
            0x2::event::emit<SpiceMinted>(v4);
            0x2::kiosk::lock<Spice>(arg2, arg3, arg1, v2);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, v3);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun mint_package(arg0: &mut MintBook, arg1: &0x2::transfer_policy::TransferPolicy<Spice>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        mint_inner(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun mint_with_rebate<T0>(arg0: &mut MintBook, arg1: &mut 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::rebate::RebateVault, arg2: &0x2::transfer_policy::TransferPolicy<Spice>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        assert!(arg0.rebate_vault == 0x1::option::some<0x2::object::ID>(0x2::object::id<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::rebate::RebateVault>(arg1)), 4);
        let v0 = mint(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::rebate::pay<T0>(arg1, arg6, arg8);
        v0
    }

    public fun minted(arg0: &MintBook) : u64 {
        arg0.minted
    }

    public fun minted_ms(arg0: &Spice) : u64 {
        arg0.minted_ms
    }

    public fun rebate_vault(arg0: &MintBook) : 0x1::option::Option<0x2::object::ID> {
        arg0.rebate_vault
    }

    public fun seal_serial(arg0: &Spice) : u64 {
        arg0.seal_serial
    }

    public(friend) fun set_paused(arg0: &mut MintBook, arg1: bool) {
        arg0.paused = arg1;
    }

    public(friend) fun set_rebate_vault(arg0: &mut MintBook, arg1: 0x2::object::ID) {
        arg0.rebate_vault = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public(friend) fun share(arg0: MintBook) {
        0x2::transfer::share_object<MintBook>(arg0);
    }

    // decompiled from Move bytecode v7
}

