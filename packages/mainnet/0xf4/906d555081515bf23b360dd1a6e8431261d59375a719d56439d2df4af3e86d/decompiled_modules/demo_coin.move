module 0xf4906d555081515bf23b360dd1a6e8431261d59375a719d56439d2df4af3e86d::demo_coin {
    struct DEMO_COIN has drop {
        dummy_field: bool,
    }

    struct DEMO_KEY_COIN has key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DEMO_COIN>, arg1: 0x2::coin::Coin<DEMO_COIN>) {
        0x2::coin::burn<DEMO_COIN>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DEMO_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DEMO_COIN>>(0x2::coin::mint<DEMO_COIN>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun set_description(arg0: &mut 0x2::coin_registry::Currency<DEMO_COIN>, arg1: &0x2::coin_registry::MetadataCap<DEMO_COIN>, arg2: 0x1::string::String) {
        0x2::coin_registry::set_description<DEMO_COIN>(arg0, arg1, arg2);
    }

    public fun set_icon_url(arg0: &mut 0x2::coin_registry::Currency<DEMO_COIN>, arg1: &0x2::coin_registry::MetadataCap<DEMO_COIN>, arg2: 0x1::string::String) {
        0x2::coin_registry::set_icon_url<DEMO_COIN>(arg0, arg1, arg2);
    }

    public fun set_name(arg0: &mut 0x2::coin_registry::Currency<DEMO_COIN>, arg1: &0x2::coin_registry::MetadataCap<DEMO_COIN>, arg2: 0x1::string::String) {
        0x2::coin_registry::set_name<DEMO_COIN>(arg0, arg1, arg2);
    }

    fun init(arg0: DEMO_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DEMO_COIN>(arg0, 9, 0x1::string::utf8(b"DC"), 0x1::string::utf8(b"Demo Coin"), 0x1::string::utf8(b"Demo Coin"), 0x1::string::utf8(b"https://demo.coin.xyz"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DEMO_COIN>>(0x2::coin_registry::finalize<DEMO_COIN>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEMO_COIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun new_name1_asset(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<DEMO_KEY_COIN>(arg0, 9, 0x1::string::utf8(b"REGISTRY"), 0x1::string::utf8(b"REGISTRY"), 0x1::string::utf8(b"REGISTRY coin"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DEMO_KEY_COIN>>(0x2::coin_registry::finalize<DEMO_KEY_COIN>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEMO_KEY_COIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun register(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<DEMO_COIN>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<DEMO_COIN>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

