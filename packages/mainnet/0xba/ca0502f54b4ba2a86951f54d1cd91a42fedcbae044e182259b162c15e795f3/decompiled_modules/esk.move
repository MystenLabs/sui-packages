module 0xbaca0502f54b4ba2a86951f54d1cd91a42fedcbae044e182259b162c15e795f3::esk {
    struct ESK has drop {
        dummy_field: bool,
    }

    public fun decimals() : u8 {
        6
    }

    public fun display_name() : 0x1::string::String {
        0x1::string::utf8(x"e5bc82e4b896e7958c")
    }

    fun init(arg0: ESK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ESK>(arg0, 6, symbol(), display_name(), 0x1::string::utf8(b"ESK ecosystem utility token"), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<ESK>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<ESK>>(0x2::coin_registry::finalize<ESK>(v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<ESK>>(0x2::coin::mint<ESK>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun symbol() : 0x1::string::String {
        0x1::string::utf8(b"ESK")
    }

    public fun total_supply_base_units() : u64 {
        1000000000000000
    }

    // decompiled from Move bytecode v7
}

