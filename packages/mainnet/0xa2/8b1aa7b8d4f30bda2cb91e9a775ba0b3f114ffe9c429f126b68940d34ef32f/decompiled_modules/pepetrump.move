module 0xa28b1aa7b8d4f30bda2cb91e9a775ba0b3f114ffe9c429f126b68940d34ef32f::pepetrump {
    struct PEPETRUMP has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEPETRUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PEPETRUMP>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PEPETRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PEPETRUMP>(arg0, 9, b"PepeWifTrump", b"PepeWifTrump", b"PepeWifTrump Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PEPETRUMP>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPETRUMP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPETRUMP>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PEPETRUMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEPETRUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PEPETRUMP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

