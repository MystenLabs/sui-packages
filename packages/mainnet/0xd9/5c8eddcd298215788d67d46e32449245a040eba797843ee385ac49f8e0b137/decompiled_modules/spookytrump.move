module 0xd95c8eddcd298215788d67d46e32449245a040eba797843ee385ac49f8e0b137::spookytrump {
    struct SPOOKYTRUMP has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SPOOKYTRUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SPOOKYTRUMP>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SPOOKYTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SPOOKYTRUMP>(arg0, 9, b"SpookyTrump", b"Spooky Trump", b"Spooky Trump Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SPOOKYTRUMP>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPOOKYTRUMP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOOKYTRUMP>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SPOOKYTRUMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SPOOKYTRUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SPOOKYTRUMP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

