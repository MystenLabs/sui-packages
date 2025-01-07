module 0x25599df6d7c36f57016b3a5e0100515f1643fb57418b169f25121becd319cc4e::ponketrump {
    struct PONKETRUMP has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PONKETRUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PONKETRUMP>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PONKETRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PONKETRUMP>(arg0, 9, b"PonkeTrump", b"PonkeTrump", b"PonkeTrump Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKxc_0SxiflUE30Fo0OIA4-RXrTLsoV-s2Sw&s")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PONKETRUMP>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PONKETRUMP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKETRUMP>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PONKETRUMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PONKETRUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PONKETRUMP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

