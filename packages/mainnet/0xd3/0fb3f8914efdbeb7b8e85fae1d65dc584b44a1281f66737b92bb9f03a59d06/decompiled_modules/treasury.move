module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::treasury {
    struct Key<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Treasury has store {
        objects: 0x2::object_bag::ObjectBag,
    }

    struct Minted<phantom T0> has copy, drop {
        amount: u64,
    }

    struct Burned<phantom T0> has copy, drop {
        amount: u64,
    }

    public(friend) fun mint<T0>(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = Minted<T0>{amount: arg1};
        0x2::event::emit<Minted<T0>>(v0);
        0x2::coin::mint<T0>(treasury_cap<T0>(arg0), arg1, arg2)
    }

    public(friend) fun mint_balance<T0>(arg0: &mut Treasury, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = Minted<T0>{amount: arg1};
        0x2::event::emit<Minted<T0>>(v0);
        0x2::coin::mint_balance<T0>(treasury_cap<T0>(arg0), arg1)
    }

    public(friend) fun burn<T0>(arg0: &mut Treasury, arg1: 0x2::balance::Balance<T0>) {
        let v0 = Burned<T0>{amount: 0x2::balance::value<T0>(&arg1)};
        0x2::event::emit<Burned<T0>>(v0);
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(treasury_cap<T0>(arg0)), arg1);
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : Treasury {
        Treasury{objects: 0x2::object_bag::new(arg0)}
    }

    fun metadata_cap<T0>(arg0: &mut Treasury) : &mut 0x2::coin_registry::MetadataCap<T0> {
        let v0 = Key<0x2::coin_registry::MetadataCap<T0>>{dummy_field: false};
        0x2::object_bag::borrow_mut<Key<0x2::coin_registry::MetadataCap<T0>>, 0x2::coin_registry::MetadataCap<T0>>(&mut arg0.objects, v0)
    }

    public(friend) fun register_metadata_cap<T0>(arg0: &mut Treasury, arg1: 0x2::coin_registry::MetadataCap<T0>) {
        let v0 = Key<0x2::coin_registry::MetadataCap<T0>>{dummy_field: false};
        0x2::object_bag::add<Key<0x2::coin_registry::MetadataCap<T0>>, 0x2::coin_registry::MetadataCap<T0>>(&mut arg0.objects, v0, arg1);
    }

    public(friend) fun register_treasury_cap<T0>(arg0: &mut Treasury, arg1: 0x2::coin::TreasuryCap<T0>) {
        let v0 = Key<0x2::coin::TreasuryCap<T0>>{dummy_field: false};
        0x2::object_bag::add<Key<0x2::coin::TreasuryCap<T0>>, 0x2::coin::TreasuryCap<T0>>(&mut arg0.objects, v0, arg1);
    }

    fun treasury_cap<T0>(arg0: &mut Treasury) : &mut 0x2::coin::TreasuryCap<T0> {
        let v0 = Key<0x2::coin::TreasuryCap<T0>>{dummy_field: false};
        0x2::object_bag::borrow_mut<Key<0x2::coin::TreasuryCap<T0>>, 0x2::coin::TreasuryCap<T0>>(&mut arg0.objects, v0)
    }

    // decompiled from Move bytecode v7
}

