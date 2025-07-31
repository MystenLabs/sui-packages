module 0x8fc4670b5264c2669f87253a679d71923d58f939d99528c4008aacd3b72305aa::ft_type {
    struct FT_TYPE has drop {
        dummy_field: bool,
    }

    struct Store has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
    }

    public fun register_bridge<T0: store + key>(arg0: &mut Store, arg1: &mut 0x752fcae2c19de64548be8fb0438ca424309bc85ff0dabbc7c9ee4c5916d2ce40::tradeport_bridge::Manager, arg2: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        0x752fcae2c19de64548be8fb0438ca424309bc85ff0dabbc7c9ee4c5916d2ce40::tradeport_bridge::register_bridge<T0, FT_TYPE>(arg1, 0x2::coin::mint<FT_TYPE>(0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, 0x2::coin::TreasuryCap<FT_TYPE>>(&mut arg0.id, 0x1::ascii::string(b"coin_treasury_cap")), 1000000000, arg2), arg2);
    }

    public fun register_bridge_with_signature<T0: store + key>(arg0: &mut Store, arg1: &mut 0x752fcae2c19de64548be8fb0438ca424309bc85ff0dabbc7c9ee4c5916d2ce40::tradeport_bridge::Manager, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        0x752fcae2c19de64548be8fb0438ca424309bc85ff0dabbc7c9ee4c5916d2ce40::tradeport_bridge::register_bridge_with_signature<T0, FT_TYPE>(arg1, arg2, 0x2::coin::mint<FT_TYPE>(0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, 0x2::coin::TreasuryCap<FT_TYPE>>(&mut arg0.id, 0x1::ascii::string(b"coin_treasury_cap")), 1000000000, arg3), arg3);
    }

    fun init(arg0: FT_TYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<FT_TYPE>(arg0, 9, b"NUM", b"Number", b"Number coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCIgdmlld0JveD0iMCAwIDEwMCAxMDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CiAgPHJlY3QgeD0iMTAiIHk9IjEwIiB3aWR0aD0iODAiIGhlaWdodD0iODAiIGZpbGw9IiMxYTIzN2UiIHN0cm9rZT0iIzBkMTY1NCIgc3Ryb2tlLXdpZHRoPSIyIi8+CiAgPHRleHQgeD0iNTAiIHk9IjUwIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBkb21pbmFudC1iYXNlbGluZT0iY2VudHJhbCIgZm9udC1mYW1pbHk9IkFyaWFsLCBzYW5zLXNlcmlmIiBmb250LXNpemU9ImNsYW1wKDEycHgsIDYwcHgsIDYwcHgpIiBmb250LXdlaWdodD0iYm9sZCIgZmlsbD0id2hpdGUiIHRleHRMZW5ndGg9IjYwIiBsZW5ndGhBZGp1c3Q9InNwYWNpbmdBbmRHbHlwaHMiPjk8L3RleHQ+Cjwvc3ZnPg==")), true, arg1);
        let v3 = Store{
            id      : 0x2::object::new(arg1),
            version : 1,
            admin   : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FT_TYPE>>(v2);
        0x2::dynamic_object_field::add<0x1::ascii::String, 0x2::coin::TreasuryCap<FT_TYPE>>(&mut v3.id, 0x1::ascii::string(b"coin_treasury_cap"), v0);
        0x2::dynamic_object_field::add<0x1::ascii::String, 0x2::coin::DenyCapV2<FT_TYPE>>(&mut v3.id, 0x1::ascii::string(b"coin_deny_cap"), v1);
        0x2::transfer::share_object<Store>(v3);
    }

    entry fun set_admin(arg0: &mut Store, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    entry fun set_version(arg0: &mut Store, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.version = arg1;
    }

    fun verify_admin(arg0: &Store, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 2);
    }

    fun verify_version(arg0: &Store) {
        assert!(arg0.version == 1, 1);
    }

    // decompiled from Move bytecode v6
}

