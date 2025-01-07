module 0xf9cec834de8291c85e6c79352e82940fe540fb386746bf082473b7314664380c::flokipepesui {
    struct FLOKIPEPESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKIPEPESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKIPEPESUI>(arg0, 6, b"FPEPES", b"Floki Pepe Sui | t.me/FlokiPepeSUI", b"Join: https://t.me/FlokiPepeSUI, https://twitter.com/FlokiPepe_SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/J9CzIkp.jpg"))), arg1);
        let v2 = v0;
        let v3 = @0x789ee726e0c2fe5027ec00d35fa2d6d77653972229b7377f1e77cc6a22a8c8eb;
        0x2::coin::mint_and_transfer<FLOKIPEPESUI>(&mut v2, 10000000000000000, v3, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOKIPEPESUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKIPEPESUI>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

