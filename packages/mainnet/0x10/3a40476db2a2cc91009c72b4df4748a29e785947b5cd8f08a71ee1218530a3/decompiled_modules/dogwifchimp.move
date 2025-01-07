module 0x103a40476db2a2cc91009c72b4df4748a29e785947b5cd8f08a71ee1218530a3::dogwifchimp {
    struct DOGWIFCHIMP has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DOGWIFCHIMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DOGWIFCHIMP>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: DOGWIFCHIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DOGWIFCHIMP>(arg0, 9, b"DogWifChimp", b"DogWifChimp", b"DogWifChimp Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<DOGWIFCHIMP>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGWIFCHIMP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGWIFCHIMP>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DOGWIFCHIMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DOGWIFCHIMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<DOGWIFCHIMP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

