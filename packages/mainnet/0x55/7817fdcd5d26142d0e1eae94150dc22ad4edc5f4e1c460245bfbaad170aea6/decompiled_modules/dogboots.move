module 0x557817fdcd5d26142d0e1eae94150dc22ad4edc5f4e1c460245bfbaad170aea6::dogboots {
    struct DOGBOOTS has drop {
        dummy_field: bool,
    }

    fun icon_url() : 0x2::url::Url {
        0x2::url::new_unsafe(0x1::ascii::string(b"https://dogboots.pages.dev/logo.png"))
    }

    fun init(arg0: DOGBOOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGBOOTS>(arg0, 9, b"DOGBOOTS", b"Dog With Boots", b"The most stylish dog on Sui. Boot up. Bark loud.", 0x1::option::some<0x2::url::Url>(icon_url()), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGBOOTS>>(0x2::coin::mint<DOGBOOTS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGBOOTS>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGBOOTS>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun update_logo(arg0: &0x2::coin::TreasuryCap<DOGBOOTS>, arg1: &mut 0x2::coin::CoinMetadata<DOGBOOTS>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<DOGBOOTS>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

