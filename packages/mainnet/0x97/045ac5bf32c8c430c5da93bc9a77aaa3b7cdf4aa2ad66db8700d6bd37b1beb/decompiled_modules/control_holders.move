module 0x97045ac5bf32c8c430c5da93bc9a77aaa3b7cdf4aa2ad66db8700d6bd37b1beb::control_holders {
    struct CONTROL_HOLDERS has drop {
        dummy_field: bool,
    }

    struct KeyHolder<T0: store + key> has store, key {
        id: 0x2::object::UID,
        cap: T0,
        cap_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct SealedMetadata<T0> has key {
        id: 0x2::object::UID,
        authority: 0x2::display_registry::DisplayCap<T0>,
    }

    public fun create_display<T0: store + key>(arg0: &mut 0x2::display_registry::DisplayRegistry, arg1: &mut 0x2::package::Publisher, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::display_registry::new_with_publisher<KeyHolder<T0>>(arg0, arg1, arg3);
        let v2 = v1;
        let v3 = v0;
        0x2::display_registry::set<KeyHolder<T0>>(&mut v3, &v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display_registry::set<KeyHolder<T0>>(&mut v3, &v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description} Original cap: {cap_id}"));
        0x2::display_registry::set<KeyHolder<T0>>(&mut v3, &v2, 0x1::string::utf8(b"image_url"), arg2);
        0x2::display_registry::share<KeyHolder<T0>>(v3);
        let v4 = SealedMetadata<KeyHolder<T0>>{
            id        : 0x2::object::new(arg3),
            authority : v2,
        };
        0x2::transfer::freeze_object<SealedMetadata<KeyHolder<T0>>>(v4);
    }

    fun init(arg0: CONTROL_HOLDERS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<CONTROL_HOLDERS>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun unwrap<T0: store + key>(arg0: KeyHolder<T0>) : T0 {
        let KeyHolder {
            id          : v0,
            cap         : v1,
            cap_id      : _,
            name        : _,
            description : _,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    fun wrap<T0: store + key>(arg0: T0, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : KeyHolder<T0> {
        let v0 = 0x2::object::id<T0>(&arg0);
        assert!(0x2::object::id_to_address(&v0) == arg1, 1);
        KeyHolder<T0>{
            id          : 0x2::object::new(arg4),
            cap         : arg0,
            cap_id      : v0,
            name        : arg2,
            description : arg3,
        }
    }

    public fun wrap_kiosk(arg0: 0x2::kiosk::KioskOwnerCap, arg1: &mut 0x2::tx_context::TxContext) : KeyHolder<0x2::kiosk::KioskOwnerCap> {
        wrap<0x2::kiosk::KioskOwnerCap>(arg0, @0xe23cfb010bf5127865f8175b9b806090f7b8e87c78f15535fb61d3ee0b689e78, 0x1::string::utf8(b"Kiosk"), 0x1::string::utf8(b"Contains the real kiosk owner authority. Unwrap to administer the kiosk."), arg1)
    }

    public fun wrap_poem_display<T0>(arg0: 0x2::display_registry::DisplayCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : KeyHolder<0x2::display_registry::DisplayCap<T0>> {
        wrap<0x2::display_registry::DisplayCap<T0>>(arg0, @0x9eff33b855f1b30fe77ffbfd85a4ab38f41834d735ea7e237dc2826aa120761c, 0x1::string::utf8(b"Poem Display"), 0x1::string::utf8(b"Contains the real poem Display authority. Unwrap to edit poem appearance."), arg1)
    }

    public fun wrap_seal_display<T0>(arg0: 0x2::display_registry::DisplayCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : KeyHolder<0x2::display_registry::DisplayCap<T0>> {
        wrap<0x2::display_registry::DisplayCap<T0>>(arg0, @0x7e16d3b886e021a820dae54b16880535d2fb24d8fc2c6b085de76918b41ff1f9, 0x1::string::utf8(b"Seal Display"), 0x1::string::utf8(b"Contains the real Admin-badge Display authority. Does not grant minting authority."), arg1)
    }

    public fun wrap_trade_rules<T0>(arg0: 0x2::transfer_policy::TransferPolicyCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : KeyHolder<0x2::transfer_policy::TransferPolicyCap<T0>> {
        wrap<0x2::transfer_policy::TransferPolicyCap<T0>>(arg0, @0x9f2f821c71299b5103278e239048cb65587ad0ad187dec5d9138eb666aee3ab5, 0x1::string::utf8(b"Trade Rules"), 0x1::string::utf8(b"Contains the real transfer-policy authority. Unwrap to manage policy rules."), arg1)
    }

    // decompiled from Move bytecode v7
}

