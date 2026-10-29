module 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials {
    struct VIALS has drop {
        dummy_field: bool,
    }

    struct Poison has store, key {
        id: 0x2::object::UID,
        doses: u64,
    }

    struct Remedy has store, key {
        id: 0x2::object::UID,
        doses: u64,
    }

    struct Elixir has store, key {
        id: 0x2::object::UID,
        doses: u64,
    }

    entry fun create_display_v2(arg0: &0x2::package::Publisher, arg1: &mut 0x2::display_registry::DisplayRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Poison>(arg0), 423);
        let v0 = 0x2::object::id<0x2::display_registry::DisplayRegistry>(arg1);
        assert!(0x2::object::id_to_address(&v0) == @0xd, 424);
        let v1 = 0x2::tx_context::sender(arg2);
        let (v2, v3) = 0x2::display_registry::new<Poison>(arg1, 0x1::internal::permit<Poison>(), arg2);
        let v4 = v3;
        let v5 = v2;
        let v6 = poison_fields();
        let v7 = keys();
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x1::string::String>(&v7)) {
            0x2::display_registry::set<Poison>(&mut v5, &v4, *0x1::vector::borrow<0x1::string::String>(&v7, v8), *0x1::vector::borrow<0x1::string::String>(&v6, v8));
            v8 = v8 + 1;
        };
        0x2::display_registry::share<Poison>(v5);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<Poison>>(v4, v1);
        let (v9, v10) = 0x2::display_registry::new<Remedy>(arg1, 0x1::internal::permit<Remedy>(), arg2);
        let v11 = v10;
        let v12 = v9;
        let v13 = remedy_fields();
        let v14 = keys();
        let v15 = 0;
        while (v15 < 0x1::vector::length<0x1::string::String>(&v14)) {
            0x2::display_registry::set<Remedy>(&mut v12, &v11, *0x1::vector::borrow<0x1::string::String>(&v14, v15), *0x1::vector::borrow<0x1::string::String>(&v13, v15));
            v15 = v15 + 1;
        };
        0x2::display_registry::share<Remedy>(v12);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<Remedy>>(v11, v1);
        let (v16, v17) = 0x2::display_registry::new<Elixir>(arg1, 0x1::internal::permit<Elixir>(), arg2);
        let v18 = v17;
        let v19 = v16;
        let v20 = elixir_fields();
        let v21 = keys();
        let v22 = 0;
        while (v22 < 0x1::vector::length<0x1::string::String>(&v21)) {
            0x2::display_registry::set<Elixir>(&mut v19, &v18, *0x1::vector::borrow<0x1::string::String>(&v21, v22), *0x1::vector::borrow<0x1::string::String>(&v20, v22));
            v22 = v22 + 1;
        };
        0x2::display_registry::share<Elixir>(v19);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<Elixir>>(v18, v1);
    }

    public fun destroy_empty_elixir(arg0: Elixir) {
        let Elixir {
            id    : v0,
            doses : v1,
        } = arg0;
        assert!(v1 == 0, 421);
        0x2::object::delete(v0);
    }

    public fun destroy_empty_poison(arg0: Poison) {
        let Poison {
            id    : v0,
            doses : v1,
        } = arg0;
        assert!(v1 == 0, 421);
        0x2::object::delete(v0);
    }

    public fun destroy_empty_remedy(arg0: Remedy) {
        let Remedy {
            id    : v0,
            doses : v1,
        } = arg0;
        assert!(v1 == 0, 421);
        0x2::object::delete(v0);
    }

    public fun elixir_doses(arg0: &Elixir) : u64 {
        arg0.doses
    }

    fun elixir_fields() : vector<0x1::string::String> {
        fields(x"4c617a6172757320456c6978697220c397207b646f7365737d", b"The rarest thing the Lazarus Well gives back. One dose awakens a risen skull, for good.", b"elixir.png")
    }

    fun fields(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : vector<0x1::string::String> {
        let v0 = 0x1::string::utf8(b"https://mortem.alienz.tech/assets/goods/v1/");
        0x1::string::append(&mut v0, 0x1::string::utf8(arg2));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(arg0));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(arg1));
        0x1::vector::push_back<0x1::string::String>(v2, v0);
        0x1::vector::push_back<0x1::string::String>(v2, v0);
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"https://mortem.alienz.tech/"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"PulseSinister & Sudcero"));
        v1
    }

    fun finish_v1<T0: key>(arg0: 0x2::display::Display<T0>, arg1: address) {
        0x2::display::update_version<T0>(&mut arg0);
        0x2::transfer::public_transfer<0x2::display::Display<T0>>(arg0, arg1);
    }

    fun init(arg0: VIALS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<VIALS>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        finish_v1<Poison>(0x2::display::new_with_fields<Poison>(&v0, keys(), poison_fields(), arg1), v1);
        finish_v1<Remedy>(0x2::display::new_with_fields<Remedy>(&v0, keys(), remedy_fields(), arg1), v1);
        finish_v1<Elixir>(0x2::display::new_with_fields<Elixir>(&v0, keys(), elixir_fields(), arg1), v1);
        let (v2, v3) = 0x2::transfer_policy::new<Poison>(&v0, arg1);
        let v4 = v3;
        let v5 = v2;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Poison>(&mut v5, &v4, 300, 0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Poison>>(v5);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Poison>>(v4, v1);
        let (v6, v7) = 0x2::transfer_policy::new<Remedy>(&v0, arg1);
        let v8 = v7;
        let v9 = v6;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Remedy>(&mut v9, &v8, 300, 0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Remedy>>(v9);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Remedy>>(v8, v1);
        let (v10, v11) = 0x2::transfer_policy::new<Elixir>(&v0, arg1);
        let v12 = v11;
        let v13 = v10;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Elixir>(&mut v13, &v12, 300, 0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Elixir>>(v13);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Elixir>>(v12, v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v1);
    }

    public fun join_elixir(arg0: &mut Elixir, arg1: Elixir) {
        let Elixir {
            id    : v0,
            doses : v1,
        } = arg1;
        0x2::object::delete(v0);
        arg0.doses = arg0.doses + v1;
    }

    public fun join_poison(arg0: &mut Poison, arg1: Poison) {
        let Poison {
            id    : v0,
            doses : v1,
        } = arg1;
        0x2::object::delete(v0);
        arg0.doses = arg0.doses + v1;
    }

    public fun join_remedy(arg0: &mut Remedy, arg1: Remedy) {
        let Remedy {
            id    : v0,
            doses : v1,
        } = arg1;
        0x2::object::delete(v0);
        arg0.doses = arg0.doses + v1;
    }

    fun keys() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        v0
    }

    public(friend) fun mint_elixir(arg0: &mut 0x2::tx_context::TxContext) : Elixir {
        Elixir{
            id    : 0x2::object::new(arg0),
            doses : 1,
        }
    }

    public(friend) fun mint_poison(arg0: &mut 0x2::tx_context::TxContext) : Poison {
        Poison{
            id    : 0x2::object::new(arg0),
            doses : 1,
        }
    }

    public(friend) fun mint_remedy(arg0: &mut 0x2::tx_context::TxContext) : Remedy {
        Remedy{
            id    : 0x2::object::new(arg0),
            doses : 1,
        }
    }

    public fun poison_doses(arg0: &Poison) : u64 {
        arg0.doses
    }

    fun poison_fields() : vector<0x1::string::String> {
        fields(x"506f69736f6e20c397207b646f7365737d", b"Drawn from the Lazarus Well. One dose curses another skull: it cannot draw from the Well until someone cures it.", b"poison.png")
    }

    public fun remedy_doses(arg0: &Remedy) : u64 {
        arg0.doses
    }

    fun remedy_fields() : vector<0x1::string::String> {
        fields(x"416e7469646f746520c397207b646f7365737d", b"Drawn from the Lazarus Well. One dose lifts a curse from any skull, or wards a clean one for a while.", b"antidote.png")
    }

    fun spend(arg0: &mut u64) {
        assert!(*arg0 > 0, 420);
        *arg0 = *arg0 - 1;
    }

    public fun split_elixir(arg0: &mut Elixir, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Elixir {
        let v0 = &mut arg0.doses;
        take(v0, arg1);
        Elixir{
            id    : 0x2::object::new(arg2),
            doses : arg1,
        }
    }

    public fun split_poison(arg0: &mut Poison, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Poison {
        let v0 = &mut arg0.doses;
        take(v0, arg1);
        Poison{
            id    : 0x2::object::new(arg2),
            doses : arg1,
        }
    }

    public fun split_remedy(arg0: &mut Remedy, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Remedy {
        let v0 = &mut arg0.doses;
        take(v0, arg1);
        Remedy{
            id    : 0x2::object::new(arg2),
            doses : arg1,
        }
    }

    fun take(arg0: &mut u64, arg1: u64) {
        assert!(arg1 > 0 && arg1 <= *arg0, 422);
        *arg0 = *arg0 - arg1;
    }

    public(friend) fun use_elixir(arg0: &mut Elixir) {
        let v0 = &mut arg0.doses;
        spend(v0);
    }

    public(friend) fun use_poison(arg0: &mut Poison) {
        let v0 = &mut arg0.doses;
        spend(v0);
    }

    public(friend) fun use_remedy(arg0: &mut Remedy) {
        let v0 = &mut arg0.doses;
        spend(v0);
    }

    // decompiled from Move bytecode v7
}

