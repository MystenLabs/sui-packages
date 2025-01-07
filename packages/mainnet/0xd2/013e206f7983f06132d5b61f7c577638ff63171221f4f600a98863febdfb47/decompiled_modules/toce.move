module 0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce {
    struct TOCE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOCE>, arg1: 0x2::coin::Coin<TOCE>) {
        0x2::coin::burn<TOCE>(arg0, arg1);
    }

    fun init(arg0: TOCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOCE>(arg0, 9, 0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::description::get_symbol(), 0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::description::get_name_coin(), 0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::description::get_description_coin(), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::description::get_image_url())), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOCE>>(v1);
        0x2::coin::mint_and_transfer<TOCE>(&mut v2, 300000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOCE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

