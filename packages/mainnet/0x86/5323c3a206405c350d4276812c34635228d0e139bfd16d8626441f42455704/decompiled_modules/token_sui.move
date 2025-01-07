module 0x865323c3a206405c350d4276812c34635228d0e139bfd16d8626441f42455704::token_sui {
    struct TOKEN_SUI has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TOKEN_SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TOKEN_SUI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TOKEN_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TOKEN_SUI>(arg0, 9, b"HONEY1", b"Honey Token 1", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dribbble.com/userupload/11357745/file/original-8c22f6682b591d5397bc9a8478900e88.jpg?resize=1024x768")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_SUI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN_SUI>>(0x2::coin::mint<TOKEN_SUI>(&mut v3, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TOKEN_SUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOKEN_SUI>>(v3);
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TOKEN_SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TOKEN_SUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

