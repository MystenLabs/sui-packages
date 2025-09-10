module 0x499b930751ecbbfbbc3b76cde04486787a6e99752df3b5d765bd5f1f441934b8::tlp_rule {
    struct TlpRule has drop {
        dummy_field: bool,
    }

    struct IndexMap has key {
        id: 0x2::object::UID,
        inner: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    fun err_unsupported_tlp_type() {
        abort 0
    }

    public fun feed<T0>(arg0: &mut 0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::PriceCollector<T0>, arg1: &IndexMap, arg2: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg3: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg1.inner, &v0)) {
            err_unsupported_tlp_type();
        };
        let (v1, v2, _, _, _) = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_pool_liquidity(arg2, arg3, *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg1.inner, &v0));
        let v6 = TlpRule{dummy_field: false};
        0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::collect<T0, TlpRule>(arg0, v6, 0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_fraction(v2, v1)));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = IndexMap{
            id    : 0x2::object::new(arg0),
            inner : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
        };
        0x2::transfer::share_object<IndexMap>(v0);
    }

    public fun remove_index<T0>(arg0: &mut IndexMap, arg1: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::listing::ListingCap) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.inner, &v0);
    }

    public fun set_index<T0>(arg0: &mut IndexMap, arg1: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::listing::ListingCap, arg2: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.inner, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.inner, &v0) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.inner, v0, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

