module 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::upers {
    struct UPERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPERS, arg1: &mut 0x2::tx_context::TxContext) {
        0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::admin::create_admin_cap(arg1);
        let (v0, v1) = 0x2::coin::create_currency<UPERS>(arg0, 6, b"UPERS", b"UP Perps", b"LP token for UP Perpetuals Market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.doubleup.fun/Diamond_Only.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UPERS>>(v1);
        0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::market::create_market<UPERS>(0x2::coin::treasury_into_supply<UPERS>(v0), 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::from_percent(5), arg1);
    }

    // decompiled from Move bytecode v6
}

