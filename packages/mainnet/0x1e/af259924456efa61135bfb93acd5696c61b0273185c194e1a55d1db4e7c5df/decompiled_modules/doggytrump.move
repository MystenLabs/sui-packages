module 0x1eaf259924456efa61135bfb93acd5696c61b0273185c194e1a55d1db4e7c5df::doggytrump {
    struct DOGGYTRUMP has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DOGGYTRUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DOGGYTRUMP>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: DOGGYTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DOGGYTRUMP>(arg0, 9, b"DoggyTrump", b"DoggyTrump", b"DoggyTrump Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<DOGGYTRUMP>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGGYTRUMP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGYTRUMP>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DOGGYTRUMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DOGGYTRUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<DOGGYTRUMP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

