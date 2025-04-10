module 0xab9da66f8cd075b6aaf3521556929b6c9eeb725ae0a85978c0e41807b3126dff::up {
    struct UpTokenMintedEvent<phantom T0> has copy, drop {
        amount: u64,
    }

    struct UpTokenBurnedEvent<phantom T0> has copy, drop {
        amount: u64,
    }

    struct UP has drop {
        dummy_field: bool,
    }

    struct UpAdmin has store, key {
        id: 0x2::object::UID,
        tokens_minted: u64,
        tokens_burned: u64,
        managers: 0x2::vec_set::VecSet<address>,
    }

    struct UPAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_manager(arg0: &UPAdminCap, arg1: &mut UpAdmin, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg1.managers, arg2);
    }

    fun borrow_up_treasury_mut(arg0: &mut UpAdmin) : &mut 0x2::coin::TreasuryCap<UP> {
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<UP>>(&mut arg0.id, 0x1::type_name::get<UP>())
    }

    public fun burn_token(arg0: &mut UpAdmin, arg1: 0x2::coin::Coin<UP>) {
        0x2::coin::burn<UP>(borrow_up_treasury_mut(arg0), arg1);
        let v0 = UpTokenBurnedEvent<UP>{amount: 0x2::coin::value<UP>(&arg1)};
        0x2::event::emit<UpTokenBurnedEvent<UP>>(v0);
    }

    fun init(arg0: UP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UP>(arg0, 6, b"UP", b"UP", b"UP Official Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.doubleup.fun/Diamond_Only.png")), arg1);
        let v2 = v0;
        let v3 = 100000000000000;
        let v4 = UpTokenMintedEvent<UP>{amount: v3};
        0x2::event::emit<UpTokenMintedEvent<UP>>(v4);
        let v5 = UpAdmin{
            id            : 0x2::object::new(arg1),
            tokens_minted : 0,
            tokens_burned : 0,
            managers      : 0x2::vec_set::empty<address>(),
        };
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<UP>>(&mut v5.id, 0x1::type_name::get<UP>(), v2);
        let v6 = UPAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::coin::Coin<UP>>(0x2::coin::mint<UP>(&mut v2, v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<UpAdmin>(v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UP>>(v1);
        0x2::transfer::public_transfer<UPAdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun is_manager(arg0: &UpAdmin, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.managers, &arg1)
    }

    public fun remove_manager(arg0: &UPAdminCap, arg1: &mut UpAdmin, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg1.managers, &arg2);
    }

    // decompiled from Move bytecode v6
}

