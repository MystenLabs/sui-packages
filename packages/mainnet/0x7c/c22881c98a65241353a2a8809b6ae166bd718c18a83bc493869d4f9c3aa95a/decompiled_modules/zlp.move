module 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::zlp {
    struct ZLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZLP, arg1: &mut 0x2::tx_context::TxContext) {
        0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::admin::create_admin_cap(arg1);
        let (v0, v1) = 0x2::coin::create_currency<ZLP>(arg0, 6, b"ZLP", b"ZO Perpetuals LP Token", b"LP Token for ZO Perpetuals Market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://img.zofinance.io/zlp.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZLP>>(v1);
        0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::market::create_market<ZLP>(0x2::coin::treasury_into_supply<ZLP>(v0), 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::rate::from_percent(5), arg1);
    }

    // decompiled from Move bytecode v6
}

