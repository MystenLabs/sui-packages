module 0x4a4602d60fdbfe5cea4a138ff47ba89aa69e839be63c1131a2af8670683c602f::key_validator {
    struct MTXAccess has drop {
        dummy_field: bool,
    }

    struct MTXKey has drop {
        dummy_field: bool,
    }

    struct MTXToken<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        value: 0x1::string::String,
        ct: u64,
        et: u64,
        image_url: 0x2::url::Url,
        description: 0x1::string::String,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct TokenCreated has copy, drop {
        token_id: address,
        owner: address,
        timestamp: u64,
    }

    struct ReturnKey has copy, drop {
        key: 0x1::string::String,
        timestamp: u64,
    }

    struct DashEvent has copy, drop {
        id: 0x2::object::ID,
        previouse_owner: address,
        current_owner: address,
        timestamp: u64,
    }

    struct KEY_VALIDATOR has drop {
        dummy_field: bool,
    }

    public entry fun buy_token_from_kiosk<T0>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::transfer_policy::TransferPolicy<MTXToken<T0>>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::purchase<MTXToken<T0>>(arg0, arg1, arg2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<MTXToken<T0>>(arg3, v1);
        0x2::transfer::public_transfer<MTXToken<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun create_display<T0: key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<MTXToken<T0>> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{value}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::display::new_with_fields<MTXToken<T0>>(arg0, v0, v2, arg1);
        0x2::display::update_version<MTXToken<T0>>(&mut v4);
        v4
    }

    public entry fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun dash_item<T0>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MTXToken<T0>>(0x2::kiosk::take<MTXToken<T0>>(arg0, arg1, arg2), arg3);
        let v0 = DashEvent{
            id              : arg2,
            previouse_owner : 0x2::tx_context::sender(arg4),
            current_owner   : arg3,
            timestamp       : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<DashEvent>(v0);
    }

    public entry fun has_mtx_token<T0>(arg0: &0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::borrow<MTXToken<T0>>(arg0, arg1, arg2);
        if (!0x2::kiosk::has_item_with_type<MTXToken<T0>>(arg0, arg2)) {
            abort 404
        };
        assert!(v0.et > 0x2::tx_context::epoch_timestamp_ms(arg3), 2);
    }

    fun init(arg0: KEY_VALIDATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<KEY_VALIDATOR>(arg0, arg1);
        let v1 = create_display<MTXToken<MTXAccess>>(&v0, arg1);
        let v2 = create_display<MTXToken<MTXKey>>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::display::Display<MTXToken<MTXToken<MTXAccess>>>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MTXToken<MTXToken<MTXKey>>>>(v2, 0x2::tx_context::sender(arg1));
        new_policy<MTXAccess>(&v0, arg1);
        new_policy<MTXKey>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::package::Publisher>(v0);
    }

    public entry fun insert<T0>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: MTXToken<T0>) {
        0x2::kiosk::place<MTXToken<T0>>(arg0, arg1, arg2);
    }

    public entry fun listing<T0>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64) {
        0x2::kiosk::list<MTXToken<T0>>(arg0, arg1, arg2, arg3);
    }

    public entry fun lock_fun<T0>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<MTXToken<T0>>, arg3: MTXToken<T0>) {
        0x2::kiosk::lock<MTXToken<T0>>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint_token_and_kiosk<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = MTXToken<T0>{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(b"MTX"),
            value       : arg0,
            ct          : 0x2::tx_context::epoch_timestamp_ms(arg5),
            et          : 0x2::tx_context::epoch_timestamp_ms(arg5) + 31536000000,
            image_url   : 0x2::url::new_unsafe(0x1::string::to_ascii(arg1)),
            description : arg2,
            balance     : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = TokenCreated{
            token_id  : 0x2::object::uid_to_address(&v0.id),
            owner     : 0x2::tx_context::sender(arg5),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x2::event::emit<TokenCreated>(v1);
        insert<T0>(arg3, arg4, v0);
    }

    public entry fun new_policy<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<MTXToken<T0>>(arg0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<MTXToken<T0>>>(v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<MTXToken<T0>>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun withdraw<T0>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MTXToken<T0>>(0x2::kiosk::take<MTXToken<T0>>(arg0, arg1, arg2), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

