module 0xf795c00bcf54ac1986e9e45968c2244c43ecfe9957fef99da4ca027a48a8f8b0::suieggy {
    struct SUIEGGY has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIEGGY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUIEGGY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUIEGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUIEGGY>(arg0, 9, b"SuiEggy", b"SuiEggy", b"SuiEggy is the yolk-powered token of the Sui blockchain, where every egg cracks a joke, and every transaction is scrambled with excitement! Powered by the light-hearted vibes of the Sui community, SuiEggy is all about hatching fun, bridging the meme culture, and putting a smile on the faces of hodlers. Designed for the carton of jokers and crypto collectors alike, SuiEggy brings a shell-abration to every wallet it touches.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SUIEGGY>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIEGGY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEGGY>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUIEGGY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIEGGY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SUIEGGY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

